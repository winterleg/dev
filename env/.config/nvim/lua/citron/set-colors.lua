---@diagnostic disable: undefined-global

DARK = "dark"
LIGHT = "light"

local state_file = vim.fn.stdpath("state") .. "/last_theme"

local current_name = nil

local function unset_curls()
  local groups = {
    -- "SpellBad", "SpellCap", "SpellLocal", "SpellRare",
    "DiagnosticUnderlineError", "DiagnosticUnderlineWarn",
    "DiagnosticUnderlineInfo", "DiagnosticUnderlineHint",
    "LspReferenceText", "LspReferenceRead", "LspReferenceWrite",
    "Type", "StorageClass", "Structure", "Typedef",
    "@lsp.type.type", "@lsp.type.class", "@lsp.type.enum",
    "@lsp.type.interface", "@lsp.type.struct", "@lsp.type.typeParameter",
    "@lsp.type.parameter", "@lsp.type.variable", "@lsp.type.property",
    "@lsp.type.enumMember", "@lsp.type.macro", "@lsp.type.method",
    "@lsp.type.function", "@lsp.type.namespace", "@lsp.type.decorator"
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { undercurl = false, underline = false })
  end
end

local function save_theme(name)
  unset_curls()
  current_name = name
  vim.fn.writefile({ name }, state_file)
end

local function load_theme()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  if vim.fn.filereadable(state_file) == 1 then
    local lines = vim.fn.readfile(state_file)
    local name = lines[1]
    if name then
      current_name = name
      return name
    end
  end
end

---@class ColorEntry
---@field name string
---@field enabled boolean
---@field callback fun()

---@type ColorEntry[]
local colorsList = {
  {
    name = "Pine",
    enabled = true,
    callback = function()
      require('rose-pine').setup({
        styles = {
          transparency = true,
        }
      })
      vim.opt.background = "dark"
      vim.cmd [[colorscheme rose-pine-main]]

      vim.api.nvim_set_hl(0, "Visual", { fg = "#191724", bg = "#e0def4" })

      save_theme "Pine"
    end,
  },
  {
    name = "Dawn",
    enabled = true,
    callback = function()
      require('rose-pine').setup({
        styles = {
          transparency = false,
        }
      })
      vim.opt.background = "light"
      vim.cmd [[colorscheme rose-pine-dawn]]

      save_theme "Dawn"
    end,
  },
  {
    name = "Gruv Dark",
    enabled = true,
    callback = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
      vim.opt.background = "dark"
      vim.cmd [[colorscheme gruvbox]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#3c3836", bg = "#ebdbb2" })

      save_theme "Gruv Dark"
    end,
  },
  {
    name = "Gruv Light",
    enabled = true,
    callback = function()
      require("gruvbox").setup({
        transparent_mode = false,
      })
      vim.opt.background = "light"
      vim.cmd [[colorscheme gruvbox]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#3c3836", fg = "#ebdbb2" })

      save_theme "Gruv Light"
    end
  },
  {
    name = "Vague",
    enabled = false,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme vague]]
      vim.api.nvim_set_hl(0, "SpellBad", { italic = false, undercurl = true })

      save_theme "Vague"
    end,
  },
  {
    name = "NERV",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-nerv]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4a2008" })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#1a0a02", bg = "#ee8822" })

      save_theme "NERV"
    end,
  },
  {
    name = "Paper",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme mfd-paper]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#a5b2a2" })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#bbc5b7", bg = "#002611" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#44693f" })

      save_theme "Paper"
    end
  },
  {
    name = "MATRIX",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-hud]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1a2a18" })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#060c06", bg = "#55bb55" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#366632" })

      save_theme "MATRIX"
    end,
  },
  {
    name = "Lotus",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme kanagawa-lotus]]

      save_theme "Lotus"
    end
  },
  {
    name = "Rusty",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme rusticated]]

      save_theme "Rusty"
    end
  },
  {
    name = "Github",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme github_dark]]
      vim.api.nvim_set_hl(0, 'Visual', { fg = "#30363d", bg = "#e4ebf1" })

      save_theme "Github"
    end,
  },
  {
    name = "cat latte",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme catppuccin-latte]]
      vim.api.nvim_set_hl(0, 'Visual', { fg = "#eff1f5", bg = "#4c4f69" })

      save_theme "cat latte"
    end,
  },
}

local themes = {}
for _, entry in ipairs(colorsList) do
  if entry.enabled then
    themes[entry.name] = entry.callback
  end
end

local name = load_theme()
if name then
  if themes[name] then
    themes[name]()
  end
end

local fs_watcher = nil

local function start_fs_watcher()
  if not vim.uv then return end
  if fs_watcher then
    fs_watcher:close()
  end
  fs_watcher = vim.uv.new_fs_event()
  if fs_watcher == nil then
    return
  end
  fs_watcher:start(state_file, {}, function(err)
    if err then return end
    vim.schedule(function()
      if vim.fn.filereadable(state_file) ~= 1 then return end
      local lines = vim.fn.readfile(state_file)
      local new_name = lines[1]
      if not new_name then return end
      if new_name == current_name then
        return
      end
      if themes[new_name] then
        current_name = nil
        themes[new_name]()
      end
    end)
  end)
end

start_fs_watcher()

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    if fs_watcher then
      fs_watcher:close()
    end
  end,
})

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function pick_theme()
  local keys = vim.tbl_keys(themes)
  table.sort(keys)

  pickers.new({}, {
    prompt_title = current_name and "Themes - Current: " .. current_name or "Themes",
    finder = finders.new_table {
      results = keys,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local function run_selection()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        themes[entry[1]]()
      end
      map("i", "<CR>", run_selection)
      map("n", "<CR>", run_selection)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>tt", pick_theme, { desc = "Pick theme" })
