---@diagnostic disable: undefined-global

_G.pdfReader = "sioyek"

local defaultToDarkMode = true

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('HighlightYank', {}),
	pattern = '*',
	callback = function()
		vim.hl.on_yank({
			higroup = 'IncSearch',
			timeout = 120,
		})
	end,
})

vim.pack.add {
	{ src = "https://github.com/vague-theme/vague.nvim",                       opts = { transparent = false } },
	{ src = "https://github.com/rose-pine/neovim",                             name = "rose-pine", },
	{ src = "https://github.com/aktersnurra/no-clown-fiesta.nvim" },

	{ src = "https://github.com/hrsh7th/nvim-cmp", },
	{ src = "https://github.com/hrsh7th/cmp-buffer", },
	{ src = "https://github.com/hrsh7th/cmp-cmdline", },
	{ src = "https://github.com/hrsh7th/cmp-path", },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip", },

	{ src = 'https://github.com/akinsho/bufferline.nvim',                      dependencies = 'nvim-tree/nvim-web-devicons', },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/junegunn/fzf",                                 lazy = false, },
	{ src = "https://github.com/junegunn/fzf.vim",                             lazy = false },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",     build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim", },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/vimwiki/vimwiki" },
	{ src = "https://github.com/nvim-mini/mini.trailspace" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip", },
}

vim.lsp.enable {
	"tinymist"
}


local bufferline = require('bufferline')

bufferline.setup {
	options = {
		indicator = {
			style = "underline",
		},
		diagnostics = "nvim_lsp",
		themable = false,
		diagnostics_indicator = function(count, level, _, _)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		sort_by = "insert_after_current"
	}
}

vim.keymap.set("n", "<C-n>", function()
	bufferline.go_to(1, true)
end, { silent = true })
vim.keymap.set("n", "<C-e>", function()
	bufferline.go_to(2, true)
end, { silent = true })
vim.keymap.set("n", "<C-i>", function()
	bufferline.go_to(3, true)
end, { silent = true })
vim.keymap.set("n", "<C-o>", function()
	bufferline.go_to(4, true)
end, { silent = true })

vim.keymap.set('n', '<A-.>', function()
	vim.cmd [[BufferLineMoveNext]]
end, { desc = 'Move buffer right' })

vim.keymap.set('n', '<A-,>', function()
	vim.cmd [[BufferLineMovePrev]]
end, { desc = 'Move buffer left' })

vim.keymap.set("n", "<A-m>", function()
	vim.cmd [[BufferLineCycleNext]]
end)
vim.keymap.set("n", "<A-k>", function()
	vim.cmd [[BufferLineCyclePrev]]
end)
vim.keymap.set("n", "<C-c>", function()
	vim.cmd [[bwipeout!]]
end, { silent = true })




require('rose-pine').setup({
	styles = {
		bold = true,
		italic = true,
		transparency = false,
	}
})

local cmp = require "cmp"
cmp.setup({
	experimental = {
		ghost_text = false
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort()
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'supermaven' }
	}, { { name = 'buffer' } })
})

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
	{ "n", "<leader>k",  ":!make<CR>",      { desc = "Call make" } },
	{ "n", "<leader>sk", function()
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





require("luasnip").setup({ enable_autosnippets = true })
vim.keymap.set({ "i", "s" }, "<C-x>", function() require("luasnip").jump(1) end, { silent = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

require("oil").setup({
	view_options = {
		show_hidden = true
	},
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"icon",
	},
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded",
	},
})

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "descending",
		borderchars = {
			"", -- top
			"", -- right
			"", -- bottom
			"", -- left
			"", -- top-left
			"", -- top-right
			"", -- bottom-right
			"", -- bottom-left
		},
		path_displays = { "shorten", "tail" },
		path_display = {
			shorten = {
				len = 1
			},
		},
		layout_config = {
			height = 100,
			width = 300,
			prompt_position = "bottom",
			preview_cutoff = 40,
		}
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")

local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)
vim.keymap.set('v', '<leader>pws', function()
	-- save current register
	local save_reg = vim.fn.getreg('"')
	local save_type = vim.fn.getregtype('"')

	-- yank visual selection into " register
	vim.cmd('normal! ""y')

	-- get yanked text
	local selection = vim.fn.getreg('"')

	-- restore register
	vim.fn.setreg('"', save_reg, save_type)

	require('telescope.builtin').grep_string({ search = selection })
end)

vim.keymap.set('n', '<leader>ps', function()
	require('telescope').extensions.live_grep_args.live_grep_args()
end)
vim.keymap.set('n', '<C-b>', builtin.buffers, {})


MiniFiles = require("mini.files")

local function open_external_or_fallback()
	local entry = MiniFiles.get_fs_entry()
	if not entry then return false end

	local path = entry.path
	local ext = vim.fn.fnamemodify(path, ":e")

	local external = {
		mp3 = { "mpv", path },
		mp4 = { "mpv", path },
		jpg = { "imv", path },
		jpeg = { "imv", path },
		png = { "imv", path },
		webp = { "imv", path },
		pdf = { pdfReader, path },
	}

	local cmd = external[ext]
	if cmd then
		vim.fn.jobstart(cmd, { detach = true })
		return true
	end

	MiniFiles.go_in()
	return false
end

local function open_stay()
	open_external_or_fallback()
end

local function open_and_close()
	open_external_or_fallback()
	MiniFiles.close()
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf = args.data.buf_id

		vim.keymap.set("n", "<CR>", open_stay, { buffer = buf, nowait = true })
		vim.keymap.set("n", "l", open_stay, { buffer = buf, nowait = true })
		vim.keymap.set("n", "L", open_and_close, { buffer = buf, nowait = true })
	end,
})


vim.g.vimwiki_path = '~/notes/'
vim.g.vimwiki_syntax = 'markdown'
vim.g.vimwiki_key_mappings = {
	all_maps = 0,
}

require('mini.trailspace').setup()





local cursorColorForDarkTheme = "#e0def4"
local cursorColorForLightTheme = "#EC5D2A" -- "#21202e"

local function pine()
	vim.opt.background = "dark"
	vim.cmd [[colorscheme rose-pine-main]]
end

local function dawn()
	vim.opt.background = "light"
	vim.cmd [[colorscheme rose-pine-dawn]]
end

local function fixColors()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	if normal.fg and normal.bg then
		vim.api.nvim_set_hl(0, "Visual", { fg = normal.bg, bg = normal.fg })
	end

	local groups = {
		"Delimiter",
		"DiagnosticUnderlineError",
		"DiagnosticUnderlineHint",
		"DiagnosticUnderlineInfo",
		"DiagnosticUnderlineWarn",
		"Structure",
		"Type",
		"TypeDef",
		"@lsp",
		"@lsp.type.type",
		"@lsp.type.class",
		"@lsp.type.struct",
		"@type",
		"DiagnosticUnderlineInfo",
		"GruvboxBlueUnderline",
		"@type.builtin",
	}
	for _, group in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = true })
		hl.underline = false
		hl.undercurl = false
		vim.api.nvim_set_hl(0, group, hl)
	end

	vim.cmd [[highlight typstMarkupHeading cterm=bold gui=bold]]

	if vim.o.background == "dark" then
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = cursorColorForDarkTheme })
		vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = cursorColorForDarkTheme })
	elseif vim.o.background == "light" then
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#FFFFFF", bg = cursorColorForLightTheme })
		vim.api.nvim_set_hl(0, "iCursor", { fg = "#FFFFFF", bg = cursorColorForLightTheme })
	end
end

if defaultToDarkMode then
	pine()
else
	dawn()
end

fixColors()

local themes = {
	{
		background = "dark",
		colorscheme = "rose-pine-main",
	},
	{
		background = "light",
		colorscheme = "rose-pine-dawn",
	},
	{
		background = "dark",
		colorscheme = "vague",
	},
}

local current = defaultToDarkMode and 1 or 2

local function apply_theme(i)
	current = i
	local theme = themes[current]

	vim.o.background = theme.background
	vim.cmd.colorscheme(theme.colorscheme)
	fixColors()

	print(theme.colorscheme)
end

vim.keymap.set("n", "<leader>kt", function()
	apply_theme(current % #themes + 1)
end)

vim.keymap.set("n", "<leader>kT", function()
	apply_theme((current - 2) % #themes + 1)
end)














vim.opt.clipboard        = "unnamedplus"
vim.o.termguicolors      = tr
vim.opt.mouse            = "a"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner       = 1
vim.g.netrw_winsize      = 25

vim.opt.cmdheight        = 0
vim.opt.laststatus       = 0

vim.opt.winborder        = "single"
vim.opt.guicursor        = {
	"a:block-Cursor",
	"i:ver30-iCursor",
	"r-cr:hor20-Cursor"
}

vim.opt.wildignorecase   = true

vim.opt.encoding         = "utf-8"
vim.opt.fileencoding     = "utf-8"
vim.opt.termguicolors    = true

vim.opt.switchbuf        = 'usetab'

vim.opt.nu               = true

vim.opt.tabstop          = 8
vim.opt.shiftwidth       = 8
vim.opt.smartindent      = true
vim.opt.softtabstop      = 8
vim.opt.expandtab        = false

vim.opt.wrap             = false
vim.opt.showbreak        = "\\-"

vim.opt.swapfile         = false
vim.opt.backup           = false
vim.opt.undodir          = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile         = true

vim.opt.hlsearch         = true
vim.opt.incsearch        = true

vim.opt.scrolloff        = 30
-- vim.opt.sidescrolloff = 0
vim.opt.isfname:append("@-@")

vim.opt.signcolumn = "no"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{,}"
vim.opt.foldlevelstart = 99

vim.opt.updatetime = 50

vim.opt.cursorline = true

vim.opt.colorcolumn = { 72, 80, 120, 180 }
vim.opt.textwidth = 72

vim.opt.list = false
vim.opt.listchars = {
	tab = "> ",
	trail = "*",
	space = "·",
	nbsp = "⍽",
}

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		local mode = vim.fn.mode()

		if mode:match("[vV\22]") then
			vim.opt.list = true
		else
			vim.opt.list = false
		end
	end,
})

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spell = true
vim.opt.spelllang = { "en", "fr", "cjk" }

if vim.g.neovide then
	-- require('neov-ime').setup()
	vim.o.guifont = "Comic Code:h23"

	vim.g.neovide_refresh_rate = 144
	vim.g.neovide_refresh_rate_idle = 10

	vim.g.neovide_scroll_animation_far_lines = 0

	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_short_animation_length = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_vfx_mode = ""

	local defaultOpacity = 0.86
	vim.g.neovide_opacity = defaultOpacity
	vim.g.neovide_normal_opacity = 1

	require("citron.sync-opacity")

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

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("GlobalFiletypeOptions", {}),
	pattern = "*",
	callback = function()
		vim.opt.tabstop = 8
		vim.opt.shiftwidth = 8
		vim.opt.softtabstop = 8
		vim.opt.expandtab = false
		vim.opt.smartindent = true
	end,
})





vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst" },
	callback = function()
		vim.opt_local.sidescrolloff = 0

		vim.opt_local.wrap          = false

		local width                 = 8
		vim.opt_local.shiftwidth    = width
		vim.opt_local.tabstop       = width
		vim.opt_local.softtabstop   = width
		vim.opt_local.expandtab     = false

		vim.opt_local.textwidth     = 72

		vim.opt_local.autoindent    = false
		vim.opt_local.smartindent   = false
		vim.opt_local.cindent       = false
		vim.opt_local.indentexpr    = ""
		vim.opt_local.indentkeys    = ""

		vim.opt_local.formatexpr    = ""

		vim.opt_local.formatoptions = "t"

		vim.keymap.set("n", "<leader>h", function()
			local file = vim.fn.expand("%:p")
			vim.system({ "typst", "c", file })
		end, { buffer = true, desc = "Compile Typst file" })
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		if vim.bo[args.buf].filetype ~= "typst" then
			return
		end

		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(args.buf) then
				vim.bo[args.buf].formatexpr = ""
			end
		end, 0)
	end,
})
