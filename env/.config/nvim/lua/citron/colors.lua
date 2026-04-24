---@diagnostic disable: undefined-global
vim.pack.add {
  { src = "https://github.com/rktjmp/lush.nvim" },
  { src = "https://github.com/NvChad/base46" },
  { src = "https://github.com/kdheepak/monochrome.nvim" },
  { src = "https://github.com/iruzo/matrix-nvim",       config = function() vim.g.matrix_disable_background = true end },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/yorickpeterse/vim-paper" },
  { src = "https://github.com/vague-theme/vague.nvim",  opts = { transparent = false } },
  { src = "https://github.com/catppuccin/nvim",         name = "catppuccin",                                           priority = 1000 },
  { src = "https://github.com/rose-pine/neovim",        name = "rose-pine", },
  {
    src = "https://github.com/zenbones-theme/zenbones.nvim",
    dependencies = "https://github.com/rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  {
    src = 'https://github.com/everviolet/nvim',
    name = 'evergarden',
    opts = {
      theme = {
        variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
        accent = 'green',
      },
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = {
          color = 'mantle',
          solid_border = false,
        },
        completion = {
          color = 'surface0',
        },
      },
    }
  },
  {
    src = "https://github.com/ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = false,
        bold = true,
        -- italic = {
        --     strings = false,
        --     emphasis = false,
        --     comments = false,
        --     operators = false,
        --     folds = false,
        -- },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
    end,
  },
  {
    src = "https://github.com/rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        transparent = true, -- do not set background color
        theme = "wave",     -- Load "wave" theme when 'background' option is not set
        background = {      -- map the value of 'background' option to a theme
          dark = "wave",    -- try "dragon" !
          light = "lotus"
        },
      })
    end
  },
  {
    src = "https://github.com/metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({
        theme = "marduk"
      })
      require("black-metal").load()
    end,
  },
  { src = "https://github.com/EdenEast/nightfox.nvim" },
  { src = "https://github.com/neanias/everforest-nvim" },
  { src = "https://github.com/kungfusheep/mfd.nvim" },
  { src = "https://github.com/projekt0n/github-nvim-theme" },
  { src = "https://github.com/d00h/nvim-rusticated" },
}

-- Default options
require('nightfox').setup {
  options = {
    transparent = false, -- Disable setting background
  },
}

require('vague').setup {
  transparent = false, -- If true, background is not set
}

require("everforest").setup({
  background = "hard",
})
