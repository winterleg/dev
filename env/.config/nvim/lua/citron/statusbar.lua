---@diagnostic disable: undefined-global
function _G.lsp_diagnostics()
	local bufnr    = vim.api.nvim_get_current_buf()

	local errors   = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
	local hints    = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
	local info     = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })

	local parts    = {}

	if errors > 0 then table.insert(parts, "E:" .. errors) end
	if warnings > 0 then table.insert(parts, "W:" .. warnings) end
	if hints > 0 then table.insert(parts, "H:" .. hints) end
	if info > 0 then table.insert(parts, "I:" .. info) end

	return table.concat(parts, " ")
end

function _G.lsp_status()
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(buf_clients) == nil then
		return ""
	end

	local names = {}
	for _, client in pairs(buf_clients) do
		table.insert(names, client.name)
	end

	return "[lsp: " .. table.concat(names, ", ") .. "]"
end

function _G.search_status()
	local sc = vim.fn.searchcount({ recompute = 1, maxcount = 9999 })
	if sc.incomplete == 1 then
		return "…"
	end
	if sc.total > 0 then
		return sc.current .. "/" .. sc.total
	end
	return ""
end

function _G.git_status()
	-- % echo $(git branch --no-color)
	-- * main
	local output = vim.fn.system("git branch --no-color")
	if vim.v.shell_error ~= 0 then
		return ""
	end

	local branch = ""

	for line in output:gmatch("[^\n]+") do
		local branch_match = line:match("%* (.+)")
		if branch_match then
			branch = branch_match
		end
	end

	if branch == "" then
		return ""
	end

	return "[Git:" .. branch .. "]"
end

function _G.tmux_status()
	if os.getenv("TMUX") == nil then
		return ""
	end

	local session = vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")
	local window = vim.fn.system("tmux display-message -p '#I'"):gsub("\n", "")

	return "[" .. session .. ":" .. window .. "]"
end

function _G.nvimcommit_status()
	if _G.isWriteCommit then
		return "nvim-commit"
	else
		return ""
	end
end

local function status_line()
	local mode = " [%{mode()}]"
	local file_name = " [%-.40t]"
	local modified = " %-m"
	-- local file_type = " %y"
	local diagnostics = " %{v:lua.lsp_diagnostics()}"
	local gits = " %{v:lua.git_status()}"
	local lsp = " %{v:lua.lsp_status()}"
	local right_align = "%="
	local line_no = "%10([%l/%L%)]"
	local search = "%{v:hlsearch ? v:lua.search_status() : ''}"
	local commit = "%{v:lua.nvimcommit_status()}"
	local tmux = "%{v:lua.tmux_status()}"

	return table.concat({
		mode,
		file_name,
		modified,
		right_align,
		search,
		diagnostics,
		gits,
		lsp,
		tmux,
		commit,
		line_no
	})
end

vim.opt.statusline = status_line()
vim.opt.laststatus = 0

vim.keymap.set("n", "<leader>ts", function()
	if vim.o.laststatus == 0 then
		vim.o.laststatus = 3
	else
		vim.o.laststatus = 0
	end
end, { desc = "Toggle statusline" })

vim.keymap.set("n", "<leader>tr", function()
	if vim.o.cmdheight == 0 then
		vim.o.cmdheight = 1
	else
		vim.o.cmdheight = 0
	end
end, { desc = "Toggle cmd line" })
