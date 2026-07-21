---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
vim.g.mapleader = " "

vim.g.fzf_layout = { window = { width = 1, height = 0.7, yoffset = 1 } }
vim.g.fzf_preview_window = { 'right:50%' }

vim.api.nvim_create_user_command("UpdateWordCount", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local filtered = {}

	for _, line in ipairs(lines) do
		if not line:match("^Words:%s*%d+$") then
			table.insert(filtered, line)
		end
	end

	local text = table.concat(filtered, "\n")

	local count = 0
	for _ in text:gmatch("%S+") do
		count = count + 1
	end

	local found = false

	for i, line in ipairs(lines) do
		if line:match("^Words:%s*%d+$") then
			lines[i] = "Words: " .. count
			found = true
			break
		end
	end

	if not found then
		table.insert(lines, "")
		table.insert(lines, "Words: " .. count)
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

vim.cmd([[
  command! -bang FilesNoPDF
    \ call fzf#vim#files(
    \   '',
    \   {
    \     'source': 'rg --files --hidden --no-ignore-vcs --glob "!.git" --glob "!*.pdf"',
    \     'options': [
    \       '--preview',
    \       'bat --style=numbers --color=always --line-range :500 {}',
    \       '--preview-window', 'right:40%',
    \       '--multi']
    \   },
    \   <bang>0
    \ )
]])

---@return table<string, function>
local function get_sessions()
	local sessions = {}
	local handle = io.popen("tmux list-sessions -F '#{session_name}' 2>/dev/null")
	if handle then
		for line in handle:lines() do
			sessions[line] = function()
				vim.fn.system("tmux switch-client -t " .. line)
			end
		end
		handle:close()
	end
	return sessions
end

---@return string?
local function get_active_session()
	local handle = io.popen("tmux display-message -p '#S' 2>/dev/null")
	if handle then
		local session = handle:read("*a"):gsub("%s+", "")
		handle:close()
		return session ~= "" and session or nil
	end
	return nil
end

local function tmux_telescope()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local sessions = get_sessions()
	local keys = vim.tbl_keys(sessions)
	table.sort(keys)

	local active = get_active_session()

	pickers.new({}, {
		prompt_title = active and "TMUX sessions - Current: " .. active or "TMUX sessions",
		finder = finders.new_table {
			results = keys,
		},
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			local function run_selection()
				local entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if entry then
					sessions[entry[1]]()
				end
			end
			map("i", "<CR>", run_selection)
			map("n", "<CR>", run_selection)
			return true
		end,
	}):find()
end

local function files_no_pdf_query()
	local query = vim.fn.input('Search: ')
	if query and query ~= '' then
		local handle = io.popen('fd --type f -E "*.pdf"')
		if handle == nil then return end
		local all_files = handle:read("*a")
		handle:close()

		local files = {}
		for line in all_files:gmatch("[^\r\n]+") do
			local basename = line:match("([^/]+)$")
			if basename and basename:lower():find(query:lower(), 1, true) then
				table.insert(files, line)
			end
		end

		if #files > 0 then
			vim.fn['fzf#vim#files']('', {
				source = files,
				options = {
					"--preview", "bat --style=numbers --color=always --line-range :500 {}",
					'--preview-window', 'right:20%',
					'--multi'
				}
			})
		end
	end
end

local function toggleWhiteSpace()
	if vim.o.list then
		vim.opt.list = false
	else
		vim.opt.list = true
	end
end

local function fzf_firefox()
	vim.fn['fzf#run']({
		source = "fd --type f",
		sink = function(selected)
			if selected and selected ~= "" then
				vim.fn.jobstart({ webBrowser, selected }, { detach = true })
			end
		end,
		options = {
			"--prompt", "Find File > ",
			"--preview", "bat --style=numbers --color=always --line-range :500 {}",
			'--preview-window', 'right:20%',
			"--multi"
		},
		window = vim.g.fzf_layout.window
	})
end

local function fzf_pdf()
	vim.fn['fzf#run']({
		source = "fd --type f --extension pdf",
		sink = function(selected)
			if selected and selected ~= "" then
				for file in selected:gmatch("[^\r\n]+") do
					vim.fn.jobstart({ pdfReader, file }, { detach = true })
				end
			end
		end,
		options = {
			"--prompt", "Find PDF > ",
			"--preview", "pdftotext {} - | head -n 200",
			'--preview-window', 'right:20%',
			"--multi"
		},
		window = vim.g.fzf_layout.window
	})
end

local function fzf_chdir()
	local currentDir = vim.fn.getcwd()
	local sources = {
		"fd . ~ --type d --follow --exclude '.*' --max-depth 2",
		"fd . ~/.config --type d --follow --max-depth 2",
	}
	if vim.fn.isdirectory("/run/media/fuyu147/VOLUME_NOIR/shared-data/") == 1 then
		table.insert(sources, "fd . /run/media/fuyu147/VOLUME_NOIR/shared-data/ --type d --follow --max-depth 3")
	end
	vim.fn['fzf#run']({
		source = table.concat(sources, " ; "),
		sink = function(selected)
			if selected and selected ~= "" then
				vim.fn.chdir(selected)
			end
		end,
		options = {
			"--prompt", currentDir .. " > ",
			"--preview", "tree -L 2 {}",
		},
		window = vim.g.fzf_layout.window
	})
end

local mappings = {
	{ "n", "<Enter>",    "<nop>" },
	{ "t", "<C-q>",      [[<C-\><C-n>]] },
	-- { "n",               "<C-t>",      "<cmd>silent !tmux-goway<CR>" },
	{ "n", "<C-t>",      fzf_chdir },
	{ "n", "<C-y>",      "<cmd>silent !tmux neww yazi-tmux<CR>" },
	{ "n", "ç",          "<CMD>Oil<CR>",                        { desc = "Open root directory" } },
	{ "n", "<leader>ç",  "<CMD>Oil .<CR>",                      { desc = "Open root directory" } },
	{ "n", "<ESC>",      "<CMD>noh<CR>" },
	{ "n", "<leader>pf", ":FilesNoPDF<CR>",                     { desc = "Open fzf (no PDFs)" } },
	{ "n", "<C-f>",      ":FilesNoPDF<CR>",                     { desc = "Open fzf (no PDFs)" } },
	{ "n", "<leader>pr", files_no_pdf_query,                    { desc = "Open fzf (no PDFs) with query" } },
	{ "n", "<leader>pk", fzf_firefox,                           { desc = "Open file in Firefox with skim" } },
	{ "n", "<leader>py", fzf_pdf },
	{ "n", "<leader>k",  ":!make<CR>",                          { desc = "Call make" } },
	{ "n", "<leader>sk", function()
		vim.cmd('split | term make')
		vim.cmd('startinsert')
	end, { desc = "Call last T command" } },
	{ 'n', '<C-k><C-v>', function()
		vim.cmd('split | term')
		vim.cmd('startinsert')
	end },
	{ 'n', '<C-k><C-t>', function()
		vim.cmd('term')
		vim.cmd('startinsert')
	end },
	{ 'n', '<C-k><C-n>', function()
		vim.cmd('enew')
	end },
	{ "n",               "<leader>sa", "ggVG" },
	{ "n",               "<leader>tw", toggleWhiteSpace },
	{ "n",               "<leader>x",  "<CMD>!chmod +x %<CR>",                 { silent = true } },
	{ "n",               "<leader>pl", "<CMD>lua MiniFiles.open()<CR>" },
	{ "n",               "<leader>q",  tmux_telescope },
	{ "n",               "<leader>gf", "<C-w>gF" },
	{ "n",               "<A-s>",      ":m +1<CR>" },
	{ "n",               "<A-r>",      ":m -2<CR>" },
	{ "v",               "<A-s>",      ":m '>+1<CR>gv" },
	{ "v",               "<A-r>",      ":m '<-2<CR>gv" },
	{ "n",               "<leader>h",  "<CMD>Gitsigns preview_hunk<CR>" },
	{ "n",               "<leader>i",  "<CMD>Gitsigns preview_hunk_inline<CR>" },
	{ { "n", "v" },      "!",          ":!" },
	{ { "n", "v" },      "<leader>w",  "<CMD>write<CR>" },
	{ { "n", "v", "x" }, "-",          "0" },
	{ { "n", "v", "x" }, ";",          ":" },
	{ { "n", "v", "x" }, ":",          ";" },
	{ { 'n', 'v', 'x' }, 'j',          'gj' },
	{ { 'n', 'v', 'x' }, 'k',          'gk' },
	{ { 'n', 'v', 'x' }, 'R',          'gR' },
	{ { 'n', 'v', 'x' }, '<leader>cz', ':center<CR>' },
	{ 'v',               'Q',          ":'<,'>UWU<CR>" },

	{ "n", "<leader>u", function()
		vim.cmd("terminal less -N " .. vim.fn.expand("%"))
		vim.cmd "startinsert"
	end, { desc = "Open In Less" } },

	{ "n", "<leader>cd", fzf_chdir,              { desc = "Change directory with skim" } },

	{ "n", "<leader>y", function()
		local pdf = vim.fn.expand("%:p:r") .. ".pdf"
		vim.fn.jobstart({ pdfReader, pdf }, { detach = true })
	end, { desc = "Open PDF" } },

	{ "n", "<leader>cw", ":UpdateWordCount<CR>", {} },

	{ "n", "<leader>pq", "<cmd>PasteImage<cr>",  { desc = "Paste image from system clipboard" } },
}


for _, value in ipairs(mappings) do
	vim.keymap.set(value[1], value[2], value[3], value[4])
end

-- local isTMUX = os.getenv "TMUX"
-- if vim.g.neovide or not isTMUX then
--   vim.keymap.set("n", "<C-t>", fzf_chdir)
-- end
