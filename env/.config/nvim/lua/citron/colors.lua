---@diagnostic disable: undefined-global
vim.pack.add {
	{ src = "https://github.com/vague-theme/vague.nvim",  opts = { transparent = false } },
	{ src = "https://github.com/catppuccin/nvim",         name = "catppuccin",                                           priority = 1000 },
	{ src = "https://github.com/rose-pine/neovim",        name = "rose-pine", },
	{ src = "https://github.com/Aejkatappaja/cendre" },
	{
		src = "https://github.com/ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},
	{ src = "https://github.com/kungfusheep/mfd.nvim" },
	{ src = "https://github.com/projekt0n/github-nvim-theme" },
}

require('vague').setup {
	transparent = false, -- If true, background is not set
}

require('rose-pine').setup({
	styles = {
		bold = true,
		italic = true,
		transparency = false,
	}
})
