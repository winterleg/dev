---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
vim.g.mapleader = " "

vim.g.fzf_layout = { window = { width = 1, height = 0.7, yoffset = 1 } }
vim.g.fzf_preview_window = { 'right:50%' }

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
	{ "n", "<C-t>",      fzf_chdir },
	{ "n", "ç",          "<CMD>Oil<CR>",    { desc = "Open root directory" } },
	{ "n", "<leader>ç",  "<CMD>Oil .<CR>",  { desc = "Open root directory" } },
	{ "n", "<ESC>",      "<CMD>noh<CR>" },
	{ "n", "<leader>pf", ":FilesNoPDF<CR>", { desc = "Open fzf (no PDFs)" } },
	{ "n", "<C-f>",      ":FilesNoPDF<CR>", { desc = "Open fzf (no PDFs)" } },
	{ "n", "<leader>sk",  ":term make<CR>",      { desc = "Call make" } },
	{ "n", "<leader>k", function()
		vim.cmd('split | term make')
		vim.cmd('startinsert')
	end, { desc = "Call make in split" } },
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
	{ "n",               "<leader>pl", "<CMD>lua MiniFiles.open()<CR>" },
	{ "n",               "<leader>gf", "<C-w>gF" },
	{ "n",               "<A-s>",      ":m +1<CR>" },
	{ "n",               "<A-r>",      ":m -2<CR>" },
	{ "v",               "<A-s>",      ":m '>+1<CR>gv" },
	{ "v",               "<A-r>",      ":m '<-2<CR>gv" },
	{ { "n", "v" },      "!",          ":!" },
	{ { "n", "v" },      "<leader>w",  "<CMD>write<CR>" },
	{ { "n", "v", "x" }, "-",          "0" },
	{ { "n", "v", "x" }, ";",          ":" },
	{ { "n", "v", "x" }, ":",          ";" },
	{ { 'n', 'v', 'x' }, 'j',          'gj' },
	{ { 'n', 'v', 'x' }, 'k',          'gk' },
	{ { 'n', 'v', 'x' }, 'R',          'gR' },
	{ { 'n', 'v', 'x' }, '<leader>cz', ':center<CR>' },

	{ "n",               "<leader>cd", fzf_chdir,                      { desc = "Change directory with skim" } },

	{ "n", "<leader>y", function()
		local pdf = vim.fn.expand("%:p:r") .. ".pdf"

		vim.fn.jobstart({ pdfReader, pdf }, { detach = true })
	end, { desc = "Open PDF" } },
}


for _, value in ipairs(mappings) do
	vim.keymap.set(value[1], value[2], value[3], value[4])
end
