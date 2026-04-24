local M = {}

local lighten = require("base46.colors").change_hex_lightness

M.base_30 = {
  white = "#e1e2e8",
  black = "#0c0e11",
  darker_black = lighten("#0c0e11", -3),
  black2 = lighten("#0c0e11", 6),
  one_bg = lighten("#0c0e11", 10),
  one_bg2 = lighten("#0c0e11", 16),
  one_bg3 = lighten("#0c0e11", 22),
  grey = "#43474e",
  grey_fg = lighten("#43474e", -10),
  grey_fg2 = lighten("#43474e", -20),
  light_grey = "#8d9199",
  red = "#ffb4ab",
  baby_pink = lighten("#ffb4ab", 10),
  pink = "#d7bee4",
  line = "#8d9199",
  green = "#d7bee4",
  vibrant_green = lighten("#d7bee4", 10),
  blue = "#a0cafd",
  nord_blue = lighten("#a0cafd", 10),
  yellow = "#bbc7db",
  sun = lighten("#bbc7db", 10),
  purple = "#d7bee4",
  dark_purple = lighten("#d7bee4", -10),
  teal = "#3b4858",
  orange = "#ffb4ab",
  cyan = "#3b4858",
  statusline_bg = lighten("#0c0e11", 6),
  pmenu_bg = "#43474e",
  folder_bg = lighten("#a0cafd", 0),
  lightbg = lighten("#0c0e11", 10),
}

M.base_16 = {
  base00 = "#0c0e11",
  base01 = lighten("#43474e", 0),
  base02 = lighten("#43474e", 3),
  base03 = lighten("#8d9199", 0),
  base04 = lighten("#c3c6cf", 0),
  base05 = "#e1e2e8",
  base06 = lighten("#e1e2e8", 0),
  base07 = "#0c0e11",
  base08 = "#ffb4ab",
  base09 = "#bbc7db",
  base0A = "#a0cafd",
  base0B = "#d7bee4",
  base0C = "#3b4858",
  base0D = lighten("#a0cafd", 20),
  base0E = "#d7bee4",
  base0F = "#e1e2e8",
}

M.type = "dark"

M.polish_hl = {
  defaults = {
    Comment = {
      italic = true,
      fg = M.base_16.base03,
    },
  },
  Syntax = {
    String = {
      fg = "#d7bee4",
    },
  },
  treesitter = {
    ["@comment"] = {
      fg = M.base_16.base03,
    },
    ["@string"] = {
      fg = "#d7bee4",
    },
  },
}

return M
