---@diagnostic disable: undefined-global
vim.opt.clipboard = "unnamedplus"
vim.o.termguicolors = tr
vim.opt.mouse = "a"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

vim.opt.cmdheight = 0

-- vim.opt.virtualedit = { -- not sure about keeping this
-- 	"block",
-- }

vim.opt.winborder = "single"
vim.opt.guicursor = {
	"a:block-Cursor",
	"i:ver30-iCursor",
	"r-cr:hor20-Cursor"
}

vim.opt.wildignorecase = true

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true

vim.opt.switchbuf = 'usetab'

vim.opt.nu = true

_G.pdfReader = "zathura"
_G.webBrowser = "firefox"

local spaceNumber = 8
vim.opt.tabstop = spaceNumber
vim.opt.shiftwidth = spaceNumber
vim.opt.smartindent = true

local useTabs = true
if useTabs then
	vim.opt.softtabstop = nil
	vim.opt.expandtab = false
else
	vim.opt.softtabstop = spaceNumber
	vim.opt.expandtab = true
end

vim.opt.wrap = false
vim.opt.showbreak = "\\-"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 30
-- vim.opt.sidescrolloff = 0
vim.opt.isfname:append("@-@")

vim.opt.signcolumn = "yes"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{,}"
vim.opt.foldlevelstart = 99

vim.opt.updatetime = 50

vim.opt.cursorline = true

vim.opt.colorcolumn = { 72, 80, 120, 180 }
vim.opt.textwidth = 80

vim.opt.list = false
vim.opt.listchars = {
	tab = "> ",
	trail = "*",
	space = "·",
	nbsp = "⍽",
}

-- Highlight group for always-visible non-breaking spaces
vim.cmd([[highlight default Nbsp guibg=#666666 guifg=#ffffff]])

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spell = true
vim.opt.spelllang = { "en", "fr", "cjk" }

_G.isWriteCommit = false

vim.api.nvim_create_user_command("ToggleWriteCommit", function()
	if _G.isWriteCommit then
		_G.isWriteCommit = false
	else
		_G.isWriteCommit = true
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*",
			callback = function()
				if _G.isWriteCommit then
					vim.cmd [[silent !git add .]]
					vim.cmd [[silent !git commit -m '...']]
				end
			end
		})
	end
end, {})

vim.api.nvim_create_user_command("OpenFirefox", function()
	vim.cmd [[!firefox %]]
end, {})

vim.api.nvim_create_user_command("UWU", function(opts)
	local start_row = opts.line1 - 1
	local end_row = opts.line2

	local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row, false)

	for i, line in ipairs(lines) do
		lines[i] = line
		    :gsub("%f[%a]th", "d")
		    :gsub("%f[%a]Th", "D")
		    :gsub("%f[%a]TH", "D")
		    :gsub("th%f[%A]", "f")
		    :gsub("Th%f[%A]", "F")
		    :gsub("TH%f[%A]", "F")
		    :gsub("ove", "uv")
		    :gsub("OVE", "UV")
		    :gsub("Ove", "Uv")
		    :gsub("n([aeiou])", "ny%1")
		    :gsub("N([aeiouAEIOU])", "Ny%1")
		    :gsub("[rl]", "w")
		    :gsub("[RL]", "W")
	end

	vim.api.nvim_buf_set_lines(0, start_row, end_row, false, lines)
end, { range = true })

vim.api.nvim_create_user_command("T", function(opts)
	local cmd = opts.args

	if opts.range > 0 then
		local content
		local s = vim.fn.getpos("'<")
		local e = vim.fn.getpos("'>")

		-- Use yank to get the exact visual selection if the range matches the marks
		if opts.line1 == s[2] and opts.line2 == e[2] then
			local reg_save = vim.fn.getreg('z')
			local regtype_save = vim.fn.getregtype('z')
			vim.cmd('silent noautocmd normal! gv"zy')
			content = vim.fn.getreg('z')
			vim.fn.setreg('z', reg_save, regtype_save)
		else
			-- Fallback for non-visual ranges (like :%T or :10,20T)
			content = table.concat(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false), "\n")
		end

		if content then
			-- Wrap in double quotes and escape internal double quotes for the shell pipe
			-- local wrapped = '"' .. content:gsub('"', '\\"') .. '"'
			cmd = string.format("%s %s", cmd, vim.fn.shellescape(content))
		end
	end
	vim.cmd("term " .. cmd)
	vim.cmd("startinsert")
end, {
	nargs = '?',
	range = true
})

if vim.g.neovide then
	-- require('neov-ime').setup()
	vim.o.guifont = "Comic Code,zen maru gothic:h23"

	vim.g.neovide_refresh_rate = 144
	vim.g.neovide_refresh_rate_idle = 10

	vim.g.neovide_scroll_animation_far_lines = 0

	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_short_animation_length = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_vfx_mode = ""

	local defaultOpacity = 0.90
	vim.g.neovide_opacity = defaultOpacity
	vim.g.neovide_normal_opacity = 1

	vim.keymap.set("n", "<leader>tp", function()
		if vim.g.neovide_opacity == defaultOpacity then
			vim.g.neovide_opacity = 1
		else
			vim.g.neovide_opacity = defaultOpacity
		end
	end)

	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	local key_factor = 1.05
	local wheel_factor = 1.01
	vim.keymap.set("n", "<C-)>", function()
		vim.g.neovide_scale_factor = 1.0
	end)
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(key_factor)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / key_factor)
	end)
	vim.keymap.set("n", "<M-ScrollWheelUp>", function()
		change_scale_factor(wheel_factor)
	end)
	vim.keymap.set("n", "<M-ScrollWheelDown>", function()
		change_scale_factor(1 / wheel_factor)
	end)
end
