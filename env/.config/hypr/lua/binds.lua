-- Binds i haven't found the equivalent to or have not done yet:
--
-- bind = $mainMod, J,           layoutmsg, togglesplit
-- bind = $mainMod, G, togglegroup
-- bind = ALT, G, moveoutofgroup
-- bind = $mainMod ALT, u, changegroupactive, f
-- bind = $mainMod ALT, l, changegroupactive, b
-- bind = $mainMod ALT, k, movegroupwindow, b
-- bind = $mainMod ALT, m, movegroupwindow, f


--- @class Key
local key = {
  a                  = "A",
  b                  = "B",
  c                  = "C",
  d                  = "D",
  e                  = "E",
  f                  = "F",
  g                  = "G",
  h                  = "H",
  i                  = "I",
  j                  = "J",
  k                  = "K",
  l                  = "L",
  m                  = "M",
  n                  = "N",
  o                  = "O",
  p                  = "P",
  q                  = "Q",
  r                  = "R",
  s                  = "S",
  t                  = "T",
  u                  = "U",
  v                  = "V",
  w                  = "W",
  x                  = "X",
  y                  = "Y",
  z                  = "Z",
  minus              = "MINUS",
  super              = "SUPER",
  return_            = "RETURN",
  shift              = "SHIFT",
  control            = "CONTROL",
  alt                = "ALT",
  tab                = "TAB",
  escape             = "ESCAPE",
  delete             = "DELETE",
  f1                 = "f1",
  f2                 = "f2",
  f3                 = "f3",
  f4                 = "f4",
  f5                 = "f5",
  f6                 = "f6",
  f7                 = "f7",
  f8                 = "f8",
  f9                 = "f9",
  f10                = "f10",
  f11                = "f11",
  f12                = "f12",
  page_up            = "page_up",
  page_down          = "page_down",
  printscr           = "code:107",
  period             = "PERIOD",
  dead_grave         = "DEAD_GRAVE",
  numbersign         = "numbersign",
  slash              = "slash",
  parenleft          = "parenleft",
  bracketleft        = "bracketleft",
  braceleft          = "braceleft",
  dead_circum        = "dead_circumflex",
  dollar             = "dollar",
  exclam             = "exclam",
  braceright         = "braceright",
  bracketright       = "bracketright",
  parenright         = "parenright",
  mouse_left         = "mouse:272",
  mouse_right        = "mouse:273",
  brightness_up      = "XF86MonBrightnessUp",
  brightness_down    = "XF86MonBrightnessDown",
  audio_raise_volume = "XF86AudioRaiseVolume",
  audio_lower_volume = "XF86AudioLowerVolume",
  audio_next         = "XF86AudioNext",
  audio_pause        = "XF86AudioPause",
  audio_play         = "XF86AudioPlay",
  audio_prev         = "XF86AudioPrev",
  audio_mute         = "XF86AudioMute",
}

--- @class Key
local workspaceKeys = {
  first   = key.slash,
  second  = key.parenleft,
  third   = key.bracketleft,
  fourth  = key.braceleft,
  fifth   = key.dead_circum,
  sixth   = key.dollar,
  seventh = key.exclam,
  eigtht  = key.braceright,
  ninth   = key.bracketright,
  tenth   = key.parenright,
}

local mainMod = key.super

local function joinKey(keys)
  return table.concat(keys, " + ")
end

-- print(joinKey({mainMod, key.x}))


---@class Bind
---@field keys table
---@field callback fun()
---@field rules? table

---@type Bind[]
local binds = {
  -- WM
  { keys = { mainMod, key.k },                     callback = hl.dsp.window.kill "activewindow" },
  { keys = { mainMod, key.f8 },                    callback = hl.dsp.exit() },
  { keys = { mainMod, key.escape },                callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/logout.sh" },
  { keys = { mainMod, key.l },                     callback = hl.dsp.exec_cmd "hyprlock" },
  { keys = { mainMod, key.v },                     callback = hl.dsp.float { action = "toggle" } },
  { keys = { mainMod, key.j },                     callback = hl.dsp.float { action = "toggle" } },
  { keys = { mainMod, key.f },                     callback = hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" } },
  { keys = { mainMod, key.p },                     callback = hl.dsp.window.pin {} },
  { keys = { mainMod, key.shift, key.p },          callback = hl.dsp.workspace.move { monitor = "+1" } },
  { keys = { key.alt, key.tab },                   callback = hl.dsp.window.cycle_next {} },
  { keys = { key.alt, key.tab },                   callback = hl.dsp.window.alter_zorder { mode = "top" } },
  { keys = { mainMod, key.tab },                   callback = hl.dsp.focus { workspace = "previous" } },
  { keys = { mainMod, key.b },                     callback = hl.dsp.exec_cmd "~/.config/waybar/waybar.sh" },
  { keys = { mainMod, key.f11 },                   callback = hl.dsp.exec_cmd "pkill hyprsunset || hyprsunset -t 4000" },
  { keys = { mainMod, key.f12 },                   callback = hl.dsp.exec_cmd "dunstctl history-pop" },

  -- app / scripts
  { keys = { mainMod, key.minus },                 callback = hl.dsp.exec_cmd "~/dotfiles/scripts/yazi-neovide" },
  { keys = { mainMod, key.control, key.v },        callback = hl.dsp.exec_cmd "cliphist list | rofi -config ~/.config/rofi/config-copy.rasi -dmenu -p \"Clipboard\" | cliphist decode | wl-copy" },
  { keys = { mainMod, key.q },                     callback = hl.dsp.exec_cmd "helium-browser" },
  { keys = { mainMod, key.return_ },               callback = hl.dsp.exec_cmd "ghostty" },
  { keys = { mainMod, key.shift, key.return_ },    callback = hl.dsp.exec_cmd "alacritty" },
  { keys = { mainMod, key.w },                     callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/open-if-not.sh firefox" },
  { keys = { mainMod, key.o },                     callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/open-if-not.sh obsidian" },
  { keys = { mainMod, key.z },                     callback = hl.dsp.exec_cmd "~/dotfiles/scripts/fzf-zathura" },
  { keys = { mainMod, key.x },                     callback = hl.dsp.exec_cmd "~/dotfiles/scripts/fzf-imv" },
  { keys = { mainMod, key.page_down },             callback = hl.dsp.exec_cmd "kitty --class=calc tmux new-session qalc" },
  { keys = { mainMod, key.r },                     callback = hl.dsp.exec_cmd "rofi -show drun -no-fixed-num-lines" },
  { keys = { mainMod, key.delete },                callback = hl.dsp.exec_cmd "rofi -show run -no-fixed-num-lines" },
  { keys = { mainMod, key.y },                     callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/WallpaperSelect.sh" },
  { keys = { mainMod, key.t },                     callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/status.sh" },
  { keys = { mainMod, key.shift, key.f },          callback = hl.dsp.exec_cmd "pcmanfm" },
  { keys = { mainMod, key.s },                     callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh simple" },
  { keys = { key.printscr },                       callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh screen" },
  { keys = { mainMod, key.shift, key.s },          callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh" },
  { keys = { mainMod, key.shift, key.t },          callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/get-text.sh" },
  { keys = { mainMod, key.shift, key.c },          callback = hl.dsp.exec_cmd "hyprpicker -a" },
  { keys = { mainMod, key.period },                callback = hl.dsp.exec_cmd "rofi -config ~/.config/rofi/config-copy.rasi -modi emoji -show emoji -no-fixed-num-lines -lines 20" },
  { keys = { mainMod, key.dead_grave },            callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/vim-scratch.sh zxcv" },
  { keys = { mainMod, key.f10 },                   callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/vim-scratch.sh zxcv" },
  { keys = { key.control, key.shift, key.o },      callback = hl.dsp.exec_cmd "wtype -M shift ] -m shift" },

  { keys = { mainMod, key.numbersign },            callback = hl.dsp.workspace.toggle_special("specialwork") },
  { keys = { mainMod, key.shift, key.numbersign }, callback = hl.dsp.window.move { workspace = "special:specialwork", follow = true } },

  { keys = { mainMod, workspaceKeys.first },       callback = hl.dsp.focus { workspace = "1" } },
  { keys = { mainMod, workspaceKeys.second },      callback = hl.dsp.focus { workspace = "2" } },
  { keys = { mainMod, workspaceKeys.third },       callback = hl.dsp.focus { workspace = "3" } },
  { keys = { mainMod, workspaceKeys.fourth },      callback = hl.dsp.focus { workspace = "4" } },
  { keys = { mainMod, workspaceKeys.fifth },       callback = hl.dsp.focus { workspace = "5" } },
  { keys = { mainMod, workspaceKeys.sixth },       callback = hl.dsp.focus { workspace = "6" } },
  { keys = { mainMod, workspaceKeys.seventh },     callback = hl.dsp.focus { workspace = "7" } },
  { keys = { mainMod, workspaceKeys.eigtht },      callback = hl.dsp.focus { workspace = "8" } },
  { keys = { mainMod, workspaceKeys.ninth },       callback = hl.dsp.focus { workspace = "9" } },
  { keys = { mainMod, workspaceKeys.tenth },       callback = hl.dsp.focus { workspace = "10" } },

  { keys = { mainMod, key.f1 },                    callback = hl.dsp.focus { workspace = "6" } },
  { keys = { mainMod, key.f2 },                    callback = hl.dsp.focus { workspace = "7" } },
  { keys = { mainMod, key.f3 },                    callback = hl.dsp.focus { workspace = "8" } },
  { keys = { mainMod, key.f4 },                    callback = hl.dsp.focus { workspace = "9" } },

  { keys = { mainMod, workspaceKeys.first },       callback = hl.dsp.window.move { workspace = "1", follow = true } },
  { keys = { mainMod, workspaceKeys.second },      callback = hl.dsp.window.move { workspace = "2", follow = true } },
  { keys = { mainMod, workspaceKeys.third },       callback = hl.dsp.window.move { workspace = "3", follow = true } },
  { keys = { mainMod, workspaceKeys.fourth },      callback = hl.dsp.window.move { workspace = "4", follow = true } },
  { keys = { mainMod, workspaceKeys.fifth },       callback = hl.dsp.window.move { workspace = "5", follow = true } },
  { keys = { mainMod, workspaceKeys.sixth },       callback = hl.dsp.window.move { workspace = "6", follow = true } },
  { keys = { mainMod, workspaceKeys.seventh },     callback = hl.dsp.window.move { workspace = "7", follow = true } },
  { keys = { mainMod, workspaceKeys.eigtht },      callback = hl.dsp.window.move { workspace = "8", follow = true } },
  { keys = { mainMod, workspaceKeys.ninth },       callback = hl.dsp.window.move { workspace = "9", follow = true } },
  { keys = { mainMod, workspaceKeys.tenth },       callback = hl.dsp.window.move { workspace = "10", follow = true } },

  { keys = { mainMod, key.f1 },                    callback = hl.dsp.window.move { workspace = "6", follow = true } },
  { keys = { mainMod, key.f2 },                    callback = hl.dsp.window.move { workspace = "7", follow = true } },
  { keys = { mainMod, key.f3 },                    callback = hl.dsp.window.move { workspace = "8", follow = true } },
  { keys = { mainMod, key.f4 },                    callback = hl.dsp.window.move { workspace = "9", follow = true } },

  { keys = { mainMod, key.h },                     callback = hl.dsp.focus { direction = "l" } },
  { keys = { mainMod, key.i },                     callback = hl.dsp.focus { direction = "r" } },
  { keys = { mainMod, key.e },                     callback = hl.dsp.focus { direction = "u" } },
  { keys = { mainMod, key.n },                     callback = hl.dsp.focus { direction = "d" } },

  { keys = { mainMod, key.shift, key.h },          callback = hl.dsp.window.move { direction = "l" } },
  { keys = { mainMod, key.shift, key.i },          callback = hl.dsp.window.move { direction = "r" } },
  { keys = { mainMod, key.shift, key.e },          callback = hl.dsp.window.move { direction = "u" } },
  { keys = { mainMod, key.shift, key.n },          callback = hl.dsp.window.move { direction = "d" } },

  { keys = { mainMod, key.mouse_left },            callback = hl.dsp.window.drag(),                                                                                                              rules = { mouse = true } },
  { keys = { mainMod, key.mouse_left },            callback = hl.dsp.window.resize(),                                                                                                            rules = { mouse = true } },

  { keys = { key.audio_raise_volume },             callback = hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && ~/.config/hypr/scripts/volume-dunst.sh" },
  { keys = { key.audio_raise_volume },             callback = hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && ~/.config/hypr/scripts/volume-dunst.sh" },
  { keys = { mainMod, key.m },                     callback = hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/.config/hypr/scripts/volume-dunst.sh" },

  { keys = { key.brightness_up },                  callback = hl.dsp.exec_cmd "brightnessctl -e s 2%+" },
  { keys = { key.brightness_down },                callback = hl.dsp.exec_cmd "brightnessctl -e s 2%-" },

  { keys = { key.audio_next },                     callback = hl.dsp.exec_cmd "playerctl next" },
  { keys = { key.audio_pause },                    callback = hl.dsp.exec_cmd "playerctl play-pause" },
  { keys = { key.audio_play },                     callback = hl.dsp.exec_cmd "playerctl play-pause" },
  { keys = { key.audio_prev },                     callback = hl.dsp.exec_cmd "playerctl previous" },
  { keys = { key.audio_mute },                     callback = hl.dsp.exec_cmd "playerctl play-pause" },
  { keys = { key.page_up },                        callback = hl.dsp.exec_cmd "~/.config/hypr/scripts/change-sound-output.sh" },
}

for _, v in ipairs(binds) do
  local keys, cb, rules = v[1], v[2], v[3]

  hl.bind(joinKey(keys), cb, rules)
end
