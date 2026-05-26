---@diagnostic disable: undefined-global

local state_file = vim.fn.stdpath("state") .. "/last_theme"

local current_name = nil

local function unset_curls()
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
end

local function save_theme(name)
  unset_curls()

  vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#EC5D2A" })
  vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#EC5D2A" })

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
          transparency = false,
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

      vim.api.nvim_set_hl(0, "Visual", { fg = "#faf4ed", bg = "#464261" })

      save_theme "Dawn"
    end,
  },
  {
    name = "Faded Dawn",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme rosebones]]

      vim.api.nvim_set_hl(0, "Visual", { fg = "#fbf6f0", bg = "#724341" })

      save_theme "Faded Dawn"
    end,
  },
  {
    name = "Gruvvy",
    enabled = true,
    callback = function()
      require("gruvbox").setup({
        transparent_mode = false,
      })
      vim.opt.background = "dark"
      vim.cmd [[colorscheme gruvbox]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#3c3836", bg = "#ebdbb2" })

      save_theme "Gruvvy"
    end,
  },
  {
    name = "Gruvvier",
    enabled = true,
    callback = function()
      require("gruvbox").setup({
        transparent_mode = false,
      })
      vim.opt.background = "light"
      vim.cmd [[colorscheme gruvbox]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#3c3836", bg = "#ebdbb2" })

      save_theme "Gruvvier"
    end,
  },
  {
    name = "KAWA",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme kanagawa-dragon]]
      vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#c5c9c5", fg = "#181616" })

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
      vim.api.nvim_set_hl(0, "Comment", { fg = "#002611" })

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
      vim.api.nvim_set_hl(0, "Visual", { fg = "#0c0404", bg = "#cc5545" })

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
      vim.api.nvim_set_hl(0, "Visual", { fg = "#181818", bg = "#909090" })

      save_theme "GRAPHITE"
    end,
  },
  {
    name = "EINK",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme e-ink]]
      -- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2e2e2e" })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#cccccc", bg = "#5e5e5e" })

      save_theme "EINK"
    end,
  },
  {
    name = "PARCHMENT",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme parchment-manuscript]]
      vim.api.nvim_set_hl(0, "Visual", { fg = "#ede4cc", bg = "#2a2018" })

      save_theme "PARCHMENT"
    end,
  },
  {
    name = "PARCHMENT PSYOP",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme parchment]]
      vim.api.nvim_set_hl(0, "Visual", { fg = "#141312", bg = "#d4c9a8" })

      save_theme "PARCHMENT PSYOP"
    end,
  },
  {
    name = "BLACK OUT",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme mfd-blackout]]
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#181c20" })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = "#24282c" })

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
      vim.api.nvim_set_hl(0, "Visual", { fg = "#0d1410", bg = "#7a9a7a" })

      save_theme "MATRIX"
    end,
  },
  {
    name = "Lotus",
    enabled = true,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme kanagawa-lotus]]

      vim.api.nvim_set_hl(0, "Visual", { fg = "#f2ecbc", bg = "#634d83" })

      save_theme "Lotus"
    end
  },
  {
    name = "Rusty",
    enabled = false,
    callback = function()
      vim.opt.background = "light"
      vim.cmd [[colorscheme rusticated]]

      vim.api.nvim_set_hl(0, "Visual", { fg = "#d3d2ce", bg = "#444136" })

      save_theme "Rusty"
    end
  },
  {
    name = "Github",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme github_dark_high_contrast]]
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
  {
    name = "cat mocha",
    enabled = true,
    callback = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme catppuccin-mocha]]
      vim.api.nvim_set_hl(0, 'Visual', { fg = "#1e1e2e", bg = "#cdd6f4" })

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
