---@diagnostic disable: undefined-global

vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/folke/zen-mode.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/junegunn/fzf",                                 lazy = false, },
  { src = "https://github.com/junegunn/fzf.vim",                             lazy = false },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",     build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim", },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/GustavEikaas/easy-dotnet.nvim" },
  { src = "https://github.com/neovim-treesitter/nvim-treesitter",            lazy = false,                                                                                                   build = "TSUpdate" },
  { src = "https://github.com/c3lang/tree-sitter-c3" },
  {
    src = "https://github.com/lervag/vimtex",
    lazy = false,
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = pdfReader

      vim.g.vimtex_compiler_latexmk = {
        executable = 'latexmk',
        options = {
          '-latex=lualatex',
          '-interaction=nonstopmode',
          '-shell-escape',
          '-pdf',
        }
      }
    end
  },
  { src = "https://github.com/ionide/Ionide-vim" },
})

vim.g["fsharp#lsp_auto_setup"] = 0
vim.g["fsharp#lsp_codelens"] = 0
vim.lsp.config("ionide", {
  on_attach = function(_, _)
    vim.lsp.codelens.clear()
  end,
  settings = {
    FSharp = {
      lineLens = {
        enabled = "never"
      },
    }
  },
})

require("nvim-treesitter").setup({})
require("mason").setup({})

require("luasnip").setup({ enable_autosnippets = true })
vim.keymap.set({ "i", "s" }, "<C-x>", function() require("luasnip").jump(1) end, { silent = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

require("oil").setup({
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

require("easy-dotnet").setup({
  lsp = {
    enabled = true,                       -- Enable builtin roslyn lsp
    preload_roslyn = true,                -- Start loading roslyn before any buffer is opened
    roslynator_enabled = true,            -- Automatically enable roslynator analyzer
    easy_dotnet_analyzer_enabled = false, -- Enable roslyn analyzer from easy-dotnet-server
    auto_refresh_codelens = true,
    analyzer_assemblies = {},             -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
    config = {},
  },
})

local telescope = require("telescope")
telescope.setup({
  defaults = {
    preview = { treesitter = true },
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
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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
-- vim.keymap.set('n', '<leader>ps', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
vim.keymap.set('n', '<leader>ps', function()
  require('telescope').extensions.live_grep_args.live_grep_args()
end)
vim.keymap.set('n', '<C-b>', builtin.buffers, {})


require("which-key").setup {
  preset = "helix",
}

require("zen-mode").setup {
  window = {
    backdrop = 0.80,
    width = 80,
    height = 0.95,
    options = {
      signcolumn = "no",      -- disable signcolumn
      number = false,         -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = true,      -- disable cursorline
      cursorcolumn = false,   -- disable cursor column
      foldcolumn = "0",       -- disable fold column
      list = false,           -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,   -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
      laststatus = 0,  -- turn off the statusline in zen mode
    },
  },
}

require('mini.files').setup({
  windows = {
    preview = true,
  },
})
