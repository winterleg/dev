---@diagnostic disable: undefined-global
vim.pack.add {
  { src = "https://github.com/rktjmp/lush.nvim" },
  { src = "https://github.com/NvChad/base46" },
  { src = "https://github.com/kdheepak/monochrome.nvim" },
  { src = "https://github.com/iruzo/matrix-nvim",       config = function() vim.g.matrix_disable_background = true end },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/vague-theme/vague.nvim",  opts = { transparent = false } },
  { src = "https://github.com/catppuccin/nvim",         name = "catppuccin",                                           priority = 1000 },
  { src = "https://github.com/rose-pine/neovim",        name = "rose-pine", },
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
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
    end,
  },
  {
    src = "https://github.com/rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        transparent = false,
        theme = "dragon",
        keywordStyle = { italic = false },
        background = {
          dark = "dragon",
          light = "lotus"
        },
      })
    end
  },
  { src = "https://github.com/kungfusheep/mfd.nvim" },
  { src = "https://github.com/projekt0n/github-nvim-theme" },
  { src = "https://github.com/d00h/nvim-rusticated" },
  { src = "https://github.com/f4z3r/gruvbox-material.nvim" },
  { src = "https://github.com/saeeedhany/parchment.nvim" },
  { src = "https://github.com/vossenwout/guts.nvim" },
  { src = "https://github.com/chriskempson/base16-vim" },
  { src = "https://github.com/gmr458/cold.nvim" },
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

-- values shown are defaults and will be used if not provided
require('gruvbox-material').setup({
  italics = true,    -- enable italics in general
  contrast = "hard", -- set contrast, can be any of "hard", "medium", "soft"
  comments = {
    italics = true,  -- enable italic comments
  },
  background = {
    transparent = false, -- set the background to be opaque
  },
  float = {
    force_background = false, -- set to true to force backgrounds on floats even when
    -- background.transparent is set
    background_color = nil,   -- set color for float backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  signs = {
    force_background = false, -- set to true to force backgrounds on signs even when
    -- background.transparent is set
    background_color = nil,   -- set color for sign backgrounds. If nil, uses the default color set
    -- by the color scheme
  },
  customize = nil, -- customize the theme in any way you desire, see below what this
  -- configuration accepts
})

require("parchment").setup({})
