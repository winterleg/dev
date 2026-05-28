---@diagnostic disable: undefined-global

vim.pack.add {
  { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
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
  { src = "https://github.com/nvzone/showkeys" },
  -- { src = "https://github.com/brenton-leighton/multiple-cursors.nvim" },
  { src = "https://github.com/vimwiki/vimwiki" },
  { src = "https://github.com/sevenc-nanashi/neov-ime.nvim" },
  { src = "https://github.com/andweeb/presence.nvim" },
}

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

require("mason").setup({})

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
  local handled_external = open_external_or_fallback()
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


-- require "multiple-cursors".setup {}
-- vim.keymap.set({ "n", "i", "x" }, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>")
-- vim.keymap.set({ "n", "i", "x" }, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>")
-- vim.keymap.set({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>")
-- vim.keymap.set({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>")
-- vim.keymap.set({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>")
-- vim.keymap.set({ "n" }, "<C-Return>", "<Cmd>MultipleCursorsAddDelete<CR>")
-- vim.keymap.set({ "x" }, "<Leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>")
-- vim.keymap.set({ "n", "x" }, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>")
-- vim.keymap.set({ "n", "x" }, "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>")
-- vim.keymap.set({ "n", "x" }, "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>")
-- vim.keymap.set({ "n", "x" }, "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>")
-- vim.keymap.set({ "n", "x" }, "<Leader>l", "<Cmd>MultipleCursorsLock<CR>")

vim.g.vimwiki_path = '~/vimwiki/'
vim.g.vimwiki_key_mappings = {
  all_maps = 0,
}
-- vim.cmd[[let g:vimwiki_list = [{'path': '~/vimwiki/',
--                       \ 'syntax': 'markdown', 'ext': 'wiki'}]
--                       ]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vimwiki" },
  callback = function()
    vim.keymap.set("n", "<Enter>", ":silent | VimwikiFollowLink<CR>")
    vim.keymap.set("n", "<leader>vz", ":silent | VimwikiBacklinks<CR>")
    vim.keymap.set("n", "<leader>vi", ":silent | VimwikiIndex<CR>")
  end
})

-- The setup config table shows all available config options with their default values:
require("presence").setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})
