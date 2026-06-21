---@diagnostic disable: undefined-global

local state_file = vim.fn.stdpath("state") .. "/last_theme"

local current_name = nil

local function fix_visual()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  if normal.fg and normal.bg then
    vim.api.nvim_set_hl(0, "Visual", { fg = normal.bg, bg = normal.fg })
  end
end

local function unset_under()
  local groups = {
    "Delimiter",                --
    "DiagnosticUnderlineError", --
    "DiagnosticUnderlineHint",  --
    "DiagnosticUnderlineInfo",  --
    "DiagnosticUnderlineWarn",  --
    "Structure",                --
    "Type",                     --
    "TypeDef",                  --
    "@lsp",                     --
    "@lsp.type.type",           --
    "@lsp.type.class",          --
    "@lsp.type.struct",         --
    "@type",                    --
    "DiagnosticUnderlineInfo",  --
    "GruvboxBlueUnderline",     --
  }
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = true })
    hl.underline = false
    hl.undercurl = false
    vim.api.nvim_set_hl(0, group, hl)
  end

  vim.cmd [[highlight typstMarkupHeading cterm=bold gui=bold]]
end

local function save_theme(name)
  unset_under()

  vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#EC5D2A" })
  vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#EC5D2A" })

  current_name = name
  vim.fn.writefile({ name }, state_file)
end

local function get_theme_from_file()
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
    name = "Vague",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme vague]]

      fix_visual()

      save_theme "Vague"
    end,
  },
  {
    name = "Pine",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme rose-pine-main]]

      fix_visual()

      save_theme "Pine"
    end,
  },
  {
    name = "Dawn",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme rose-pine-dawn]]

      fix_visual()

      save_theme "Dawn"
    end,
  },
  {
    name = "Gruvvy",
    enabled = false,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme gruvbox]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })

      fix_visual()

      save_theme "Gruvvy"
    end,
  },
  {
    name = "KAWA",
    enabled = false,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme kanagawa-dragon]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })

      fix_visual()

      save_theme "KAWA"
    end
  },
  {
    name = "NERV",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-nerv]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4a2008" })

      fix_visual()

      save_theme "NERV"
    end,
  },
  {
    name = "Green Paper",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme mfd-paper]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#a5b2a2" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#002611" })

      fix_visual()

      save_theme "Paper"
    end
  },
  {
    name = "SCARLET",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-scarlet]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2a100a" })

      fix_visual()

      save_theme "SCARLET"
    end,
  },
  {
    name = "GRAPHITE",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-flir]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2e2e2e" })

      fix_visual()

      save_theme "GRAPHITE"
    end,
  },
  {
    name = "PARCHMENT",
    enabled = false,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme parchment-manuscript]]

      fix_visual()

      save_theme "PARCHMENT"
    end,
  },
  {
    name = "PARCHMENT PSYOP",
    enabled = false,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme parchment]]

      fix_visual()

      save_theme "PARCHMENT PSYOP"
    end,
  },
  {
    name = "BLACK OUT",
    enabled = false,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-blackout]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#181c20" })

      fix_visual()

      save_theme "BLACK OUT"
    end,
  },
  {
    name = "MATRIX",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-stealth]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2a3a2a" })

      fix_visual()

      save_theme "MATRIX"
    end,
  },
  {
    name = "Lotus",
    enabled = false,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme kanagawa-lotus]]

      fix_visual()

      save_theme "Lotus"
    end
  },
  {
    name = "Rusty",
    enabled = false,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme rusticated]]

      fix_visual()

      save_theme "Rusty"
    end
  },
  {
    name = "Github",
    enabled = false,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme github_dark_high_contrast]]

      fix_visual()

      save_theme "Github"
    end,
  },
  {
    name = "cat latte",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme catppuccin-latte]]

      fix_visual()

      save_theme "cat latte"
    end,
  },
  {
    name = "cat mocha",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme catppuccin-mocha]]

      fix_visual()

      save_theme "cat mocha"
    end,
  },
}

local themes = {}
for _, entry in ipairs(colorsList) do
  if entry.enabled then
    themes[entry.name] = entry.callback
  end
end

local name = get_theme_from_file()
if name then
  if themes[name] then
    vim.cmd("syntax reset")
    unset_under()
    themes[name]()
  end
end

unset_under()

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

        unset_under()
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
