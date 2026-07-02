require "lua.keys"
require "lua.scripts.ws_exec"
require "lua.scripts.focus_direction"
require "lua.scripts.monitors"
require "lua.scripts.layout"
require "lua.scripts.floating"

-- local handle = io.popen("switcherooctl list")
-- local output
-- if handle then
--   output = handle:read("*a")
--   handle:close()
-- end
--
local fancy = true

local termCall
local nvimCall
-- if output:lower():find("nvidia") then
if fancy then
  termCall = "alacritty"
  nvimCall = "switcherooctl launch -g 1 neovide"
else
  termCall = "foot"
  -- nvimCall = "foot sh -c 'tmux attach || tmux new-session -s main nvim'"
  nvimCall = "foot -e nvim"
end


---@class Bind
---@field k table
---@field c function|HL.Dispatcher
---@field r? table

---@type Bind[]
local binds = {
  -- WM
  { k = { MainMod, Key.c },                         c = hl.dsp.window.close {} },
  { k = { MainMod, Key.f8 },                        c = hl.dsp.exit() },
  { k = { MainMod, Key.escape },                    c = hl.dsp.exec_cmd "~/.config/hypr/scripts/logout.sh" },
  { k = { MainMod, Key.l },                         c = hl.dsp.exec_cmd "hyprlock" },
  { k = { MainMod, Key.v },                         c = hl.dsp.window.float { action = "toggle" } },
  { k = { MainMod, Key.f },                         c = hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" } },
  { k = { MainMod, Key.p },                         c = hl.dsp.group.toggle {} },
  { k = { MainMod, NumberLayer.seventh },           c = hl.dsp.window.move { out_of_group = true } },
  { k = { MainMod, NumberLayer.eigtht },            c = hl.dsp.group.prev {} },
  { k = { MainMod, NumberLayer.ninth },             c = hl.dsp.group.next {} },
  { k = { MainMod, Key.j },                         c = hl.dsp.layout("togglesplit") },
  { k = { MainMod, Key.shift, Key.p },              c = hl.dsp.workspace.move { monitor = "+1" } },
  { k = { Key.alt, Key.tab },                       c = hl.dsp.window.cycle_next {} },
  { k = { Key.alt, Key.tab },                       c = hl.dsp.window.alter_zorder { mode = "top" } },
  { k = { MainMod, Key.tab },                       c = hl.dsp.focus { workspace = "previous" } },
  { k = { MainMod, Key.b },                         c = hl.dsp.exec_cmd "~/.config/waybar/waybar.sh" },
  { k = { MainMod, Key.f11 },                       c = hl.dsp.exec_cmd "pkill hyprsunset || hyprsunset -t 4000" },
  { k = { MainMod, Key.f12 },                       c = hl.dsp.exec_cmd "dunstctl history-pop" },
  { k = { MainMod, Key.g },                         c = function() ToggleLayout() end },
  { k = { MainMod, Key.shift, Key.g },              c = function() FloatingToggle() end },

  -- app / scripts
  { k = { MainMod, Key.minus },                     c = hl.dsp.exec_cmd "~/dotfiles/scripts/tts-neovide" },
  { k = { MainMod, Key.control, Key.v },            c = hl.dsp.exec_cmd "cliphist list | rofi -config ~/.config/rofi/config-copy.rasi -dmenu -p \"Clipboard\" | cliphist decode | wl-copy" },
  { k = { MainMod, Key.q },                         c = hl.dsp.exec_cmd "helium-browser" },
  { k = { MainMod, Key.return_ },                   c = hl.dsp.exec_cmd(nvimCall) },
  { k = { MainMod, Key.shift, Key.return_ },        c = hl.dsp.exec_cmd(termCall) },
  { k = { MainMod, Key.w },                         c = hl.dsp.exec_cmd "~/.local/bin/firefox" },
  { k = { MainMod, Key.shift, Key.w },              c = hl.dsp.exec_cmd "~/.local/bin/thunderbird" },
  { k = { MainMod, Key.shift, Key.v },              c = hl.dsp.exec_cmd "~/.local/bin/vesktop" },
  { k = { MainMod, Key.z },                         c = hl.dsp.exec_cmd "~/dotfiles/scripts/fzf-zathura" },
  { k = { MainMod, Key.x },                         c = hl.dsp.exec_cmd "~/dotfiles/scripts/fzf-imv" },
  { k = { MainMod, Key.r },                         c = hl.dsp.exec_cmd "rofi -show drun -no-fixed-num-lines" },
  { k = { MainMod, Key.shift, Key.r },              c = hl.dsp.exec_cmd "rofi -show run" },
  { k = { MainMod, Key.y },                         c = hl.dsp.exec_cmd "~/.config/hypr/scripts/WallpaperSelect.sh" },
  { k = { MainMod, Key.shift, Key.f },              c = hl.dsp.exec_cmd "pcmanfm" },
  { k = { MainMod, Key.k },                         c = hl.dsp.exec_cmd(termCall .. " -e rmpc") },
  { k = { MainMod, Key.s },                         c = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh simple" },
  { k = { Key.printscr },                           c = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh screen" },
  { k = { MainMod, Key.shift, Key.s },              c = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh" },
  { k = { MainMod, Key.shift, Key.t },              c = hl.dsp.exec_cmd "~/.config/hypr/scripts/get-text.sh" },
  { k = { MainMod, Key.shift, Key.c },              c = hl.dsp.exec_cmd "hyprpicker -a" },
  { k = { MainMod, Key.period },                    c = hl.dsp.exec_cmd "rofi -config ~/.config/rofi/config-copy.rasi -modi emoji -show emoji -no-fixed-num-lines -lines 20" },

  { k = { MainMod, Key.numbersign },                c = hl.dsp.workspace.toggle_special("specialwork") },
  { k = { MainMod, Key.shift, Key.numbersign },     c = hl.dsp.window.move { workspace = "special:specialwork", follow = true } },

  { k = { MainMod, NumberLayer.first },             c = hl.dsp.focus { workspace = "1" } },
  { k = { MainMod, NumberLayer.second },            c = hl.dsp.focus { workspace = "2" } },
  { k = { MainMod, NumberLayer.third },             c = hl.dsp.focus { workspace = "3" } },
  { k = { MainMod, NumberLayer.fourth },            c = hl.dsp.focus { workspace = "4" } },
  { k = { MainMod, NumberLayer.fifth },             c = hl.dsp.focus { workspace = "5" } },
  { k = { MainMod, NumberLayer.tenth },             c = hl.dsp.focus { workspace = "10" } },

  { k = { MainMod, Key.shift, NumberLayer.first },  c = hl.dsp.window.move { workspace = "1", follow = true } },
  { k = { MainMod, Key.shift, NumberLayer.second }, c = hl.dsp.window.move { workspace = "2", follow = true } },
  { k = { MainMod, Key.shift, NumberLayer.third },  c = hl.dsp.window.move { workspace = "3", follow = true } },
  { k = { MainMod, Key.shift, NumberLayer.fourth }, c = hl.dsp.window.move { workspace = "4", follow = true } },
  { k = { MainMod, Key.shift, NumberLayer.fifth },  c = hl.dsp.window.move { workspace = "5", follow = true } },
  { k = { MainMod, Key.shift, NumberLayer.tenth },  c = hl.dsp.window.move { workspace = "10", follow = true } },

  { k = { MainMod, Key.h },                         c = function() Focus_fs("l") end },
  { k = { MainMod, Key.i },                         c = function() Focus_fs("r") end },
  { k = { MainMod, Key.e },                         c = function() Focus_fs("u") end },
  { k = { MainMod, Key.n },                         c = function() Focus_fs("d") end },

  { k = { MainMod, Key.shift, Key.h },              c = hl.dsp.window.move { direction = "l" } },
  { k = { MainMod, Key.shift, Key.i },              c = hl.dsp.window.move { direction = "r" } },
  { k = { MainMod, Key.shift, Key.e },              c = hl.dsp.window.move { direction = "u" } },
  { k = { MainMod, Key.shift, Key.n },              c = hl.dsp.window.move { direction = "d" } },

  { k = { MainMod, Mouse.click_left },              c = hl.dsp.window.drag(),                                                                                                              r = { mouse = true } },
  { k = { MainMod, Mouse.click_right },             c = hl.dsp.window.resize(),                                                                                                            r = { mouse = true } },

  { k = { MainMod, Mouse.wheel_up },                c = hl.dsp.focus { workspace = "e+1" },                                                                                                r = { mouse = true } },
  { k = { MainMod, Mouse.wheel_down },              c = hl.dsp.focus { workspace = "e-1" },                                                                                                r = { mouse = true } },

  { k = { Key.audio_raise_volume },                 c = hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && ~/.config/hypr/scripts/volume-dunst.sh" },
  { k = { Key.audio_lower_volume },                 c = hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && ~/.config/hypr/scripts/volume-dunst.sh" },
  { k = { MainMod, Key.m },                         c = hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/.config/hypr/scripts/volume-dunst.sh" },

  { k = { Key.brightness_up },                      c = hl.dsp.exec_cmd "brightnessctl -e s 2%+" },
  { k = { Key.brightness_down },                    c = hl.dsp.exec_cmd "brightnessctl -e s 2%-" },

  { k = { Key.audio_next },                         c = hl.dsp.exec_cmd "playerctl next" },
  { k = { Key.audio_pause },                        c = hl.dsp.exec_cmd "playerctl play-pause" },
  { k = { Key.audio_play },                         c = hl.dsp.exec_cmd "playerctl play-pause" },
  { k = { Key.audio_prev },                         c = hl.dsp.exec_cmd "playerctl previous" },
  { k = { Key.audio_mute },                         c = hl.dsp.exec_cmd "playerctl play-pause" },
  { k = { MainMod, Key.page_up },                   c = hl.dsp.exec_cmd "pavucontrol" },

  { k = { MainMod, Key.shift, Key.control, Key.u }, c = UpdateMonitors },
}

for _, v in pairs(binds) do
  hl.bind(table.concat(v.k, " + "), v.c, v.r)
end
