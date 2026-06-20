---@diagnostic disable: undefined-global

vim.pack.add {
  { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
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
  { src = "https://github.com/ionide/Ionide-vim" },
  -- { src = "https://github.com/nvzone/showkeys" },
  { src = "https://github.com/vimwiki/vimwiki" },
  { src = "https://github.com/sevenc-nanashi/neov-ime.nvim" },
  -- { src = "https://github.com/andweeb/presence.nvim" },
  -- { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/ray-x/lsp_signature.nvim" },
  { src = "https://github.com/chentoast/marks.nvim" },
  { src = "https://github.com/HakonHarnes/img-clip.nvim" },
  { src = "https://github.com/nvim-mini/mini.trailspace" },
  -- { src = "https://github.com/gelguy/wilder.nvim" },
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" }
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
vim.g.vimwiki_key_mappings = {
  all_maps = 0,
}

-- -- The setup config table shows all available config options with their default values:
-- require("presence").setup {
--   -- General options
--   auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
--   neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
--   main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
--   client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
--   log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
--   debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
--   enable_line_number  = false,                      -- Displays the current line number instead of the current project
--   blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
--   buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
--   file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
--   show_time           = true,                       -- Show the timer
--
--   -- Rich Presence text options
--   editing_text        = "Editing %s",         -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
--   file_explorer_text  = "Browsing %s",        -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
--   git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
--   plugin_manager_text = "Managing plugins",   -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
--   reading_text        = "Reading %s",         -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
--   workspace_text      = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
--   line_number_text    = "Line %s out of %s",  -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
-- }

-- require('neo-tree').setup {
--   window     = {
--     position          = "right",
--     width             = 30,
--     auto_expand_width = false,
--
--     mappings          = {
--       ["w"] = "noop"
--     }
--   },
--   filesystem = {
--     window = {
--       mappings = {
--         ["b"] = "noop",
--         ["/"] = { "fuzzy_finder", config = { keep_filter_on_submit = true } }
--       }
--     }
--   }
-- }

local sigConfig = {
  bind = true,
  handler_opts = {
    border = "rounded"
  }
}
local sig = require("lsp_signature")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    if ft == "fsharp" then
      return
    end

    sig.on_attach(sigConfig, args.buf)
  end,
})

require 'marks'.setup {
  default_mappings = true,
  builtin_marks = { ".", "<", ">", "^", "a", "r", "s", "t" },
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  excluded_filetypes = {},
  excluded_buftypes = {},
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    annotate = false,
  },
  mappings = {}
}

require("img-clip").setup {
  default = {
    -- file and directory options
    dir_path = "assets", ---@type string | fun(): string
    extension = "png", ---@type string | fun(): string
    file_name = "%Y-%m-%d-%H-%M-%S", ---@type string | fun(): string
    use_absolute_path = false, ---@type boolean | fun(): boolean
    relative_to_current_file = true, ---@type boolean | fun(): boolean

    -- logging options
    verbose = true, ---@type boolean | fun(): boolean

    -- template options
    template = "$FILE_PATH", ---@type string | fun(context: table): string
    url_encode_path = false, ---@type boolean | fun(): boolean
    relative_template_path = true, ---@type boolean | fun(): boolean
    use_cursor_in_template = true, ---@type boolean | fun(): boolean
    insert_mode_after_paste = true, ---@type boolean | fun(): boolean
    insert_template_after_cursor = true, ---@type boolean | fun(): boolean

    -- prompt options
    prompt_for_file_name = true, ---@type boolean | fun(): boolean
    show_dir_path_in_prompt = false, ---@type boolean | fun(): boolean

    -- base64 options
    max_base64_size = 10, ---@type number | fun(): number
    embed_image_as_base64 = false, ---@type boolean | fun(): boolean

    -- image options
    process_cmd = "", ---@type string | fun(): string
    copy_images = false, ---@type boolean | fun(): boolean
    download_images = true, ---@type boolean | fun(): boolean
    formats = { "jpeg", "jpg", "png" }, ---@type string[]

    -- drag and drop options
    drag_and_drop = {
      enabled = true, ---@type boolean | fun(): boolean
      insert_mode = false, ---@type boolean | fun(): boolean
    },
  },

  -- filetype specific options
  filetypes = {
    typst = {
      template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]], ---@type string | fun(context: table): string
    },
  },

  -- file, directory, and custom triggered options
  files = {}, ---@type table | fun(): table
  dirs = {}, ---@type table | fun(): table
  custom = {}, ---@type table | fun(): table
}

require('mini.trailspace').setup()

-- require "wilder".setup {
--   next_key = '<C-n>',
--   previous_key = '<C-p>',
--   accept_key = '<C-y>',
--   reject_key = '<C-e>',
-- }

require("tree-sitter-manager").setup()
