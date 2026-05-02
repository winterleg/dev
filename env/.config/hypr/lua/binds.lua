require "lua.keys"

-- Binds i haven't found the equivalent to or have not done yet:
--
-- bind = $MainMod, J,           layoutmsg, togglesplit
-- bind = $MainMod, G, togglegroup
-- bind = ALT, G, moveoutofgroup
-- bind = $MainMod ALT, u, changegroupactive, f
-- bind = $MainMod ALT, l, changegroupactive, b
-- bind = $MainMod ALT, k, movegroupwindow, b
-- bind = $MainMod ALT, m, movegroupwindow, f

--- @param cmd string
--- @param ws integer
local function ws_exec(cmd, ws)
  hl.dispatch(hl.dsp.focus { workspace = ws })
  hl.dispatch(hl.dsp.exec_cmd(cmd))
end

--- @param window_class string
--- @param window_exe string
--- @param default_ws integer?
local function toggle_or_focus_window(window_class, window_exe, default_ws)
  local wins = hl.get_windows { class = window_class }
  local active = hl.get_active_window()

  if #wins == 0 then
    hl.dispatch(hl.dsp.exec_cmd(window_exe))
    return
  end

  local win = wins[1]

  if active ~= nil and active.address == win.address then
    hl.dispatch(hl.dsp.window.move {
      window    = win,
      workspace = "special:shadowrealm",
      follow    = false,
    })
    return
  end

  if win.workspace.special then
    if default_ws ~= nil then
      hl.dispatch(hl.dsp.window.move {
        window    = win,
        workspace = default_ws,
        follow    = false,
      })
    end
  end

  hl.dispatch(hl.dsp.focus { window = win })
end


---@class Bind
---@field k table
---@field c fun()
---@field r? table

---@type Bind[]
local binds = {
  -- WM
  { k = { MainMod, Key.c },                     c = hl.dsp.window.close {} },
  { k = { MainMod, Key.f8 },                    c = hl.dsp.exit() },
  { k = { MainMod, Key.escape },                c = hl.dsp.exec_cmd "~/.config/hypr/scripts/logout.sh" },
  { k = { MainMod, Key.l },                     c = hl.dsp.exec_cmd "hyprlock" },
  { k = { MainMod, Key.v },                     c = hl.dsp.window.float { action = "toggle" } },
  { k = { MainMod, Key.f },                     c = hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" } },
  { k = { MainMod, Key.p },                     c = hl.dsp.window.pin {} },
  { k = { MainMod, Key.j },                     c = hl.dsp.layout("togglesplit") },
  { k = { MainMod, Key.shift, Key.p },          c = hl.dsp.workspace.move { monitor = "+1" } },
  { k = { Key.alt, Key.tab },                   c = hl.dsp.window.cycle_next {} },
  { k = { Key.alt, Key.tab },                   c = hl.dsp.window.alter_zorder { mode = "top" } },
  { k = { MainMod, Key.tab },                   c = hl.dsp.focus { workspace = "previous" } },
  { k = { MainMod, Key.b },                     c = hl.dsp.exec_cmd "~/.config/waybar/waybar.sh" },
  { k = { MainMod, Key.f11 },                   c = hl.dsp.exec_cmd "pkill hyprsunset || hyprsunset -t 4000" },
  { k = { MainMod, Key.f12 },                   c = hl.dsp.exec_cmd "dunstctl history-pop" },

  -- app / scripts
  { k = { MainMod, Key.minus },                 c = hl.dsp.exec_cmd "~/dotfiles/scripts/yazi-neovide" },
  { k = { MainMod, Key.control, Key.v },        c = hl.dsp.exec_cmd "cliphist list | rofi -config ~/.config/rofi/config-copy.rasi -dmenu -p \"Clipboard\" | cliphist decode | wl-copy" },
  { k = { MainMod, Key.q },                     c = hl.dsp.exec_cmd "helium-browser" },
  { k = { MainMod, Key.return_ },               c = hl.dsp.exec_cmd "ghostty" },
  { k = { MainMod, Key.shift, Key.return_ },    c = hl.dsp.exec_cmd "alacritty" },
  { k = { MainMod, Key.w },                     c = hl.dsp.exec_cmd "firefox" },
  { k = { MainMod, Key.o },                     c = hl.dsp.exec_cmd "~/.config/hypr/scripts/open-if-not.sh obsidian" },
  { k = { MainMod, Key.z },                     c = hl.dsp.exec_cmd "~/dotfiles/scripts/fzf-zathura" },
  { k = { MainMod, Key.x },                     c = hl.dsp.exec_cmd "~/dotfiles/scripts/fzf-imv" },
  { k = { MainMod, Key.page_down },             c = hl.dsp.exec_cmd "kitty --class=calc tmux new-session qalc" },
  { k = { MainMod, Key.r },                     c = hl.dsp.exec_cmd "rofi -show drun -no-fixed-num-lines" },
  { k = { MainMod, Key.delete },                c = hl.dsp.exec_cmd "rofi -show run -no-fixed-num-lines" },
  { k = { MainMod, Key.y },                     c = hl.dsp.exec_cmd "~/.config/hypr/scripts/WallpaperSelect.sh" },
  { k = { MainMod, Key.t },                     c = hl.dsp.exec_cmd "~/.config/hypr/scripts/status.sh" },
  { k = { MainMod, Key.shift, Key.f },          c = hl.dsp.exec_cmd "thunar" },
  { k = { MainMod, Key.s },                     c = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh simple" },
  { k = { Key.printscr },                       c = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh screen" },
  { k = { MainMod, Key.shift, Key.s },          c = hl.dsp.exec_cmd "~/.config/hypr/scripts/hyprshot.sh" },
  { k = { MainMod, Key.shift, Key.t },          c = hl.dsp.exec_cmd "~/.config/hypr/scripts/get-text.sh" },
  { k = { MainMod, Key.shift, Key.c },          c = hl.dsp.exec_cmd "hyprpicker -a" },
  { k = { MainMod, Key.period },                c = hl.dsp.exec_cmd "rofi -config ~/.config/rofi/config-copy.rasi -modi emoji -show emoji -no-fixed-num-lines -lines 20" },
  { k = { MainMod, Key.dead_grave },            c = hl.dsp.exec_cmd "~/.config/hypr/scripts/vim-scratch.sh zxcv" },
  { k = { MainMod, Key.f10 },                   c = hl.dsp.exec_cmd "~/.config/hypr/scripts/vim-scratch.sh zxcv" },
  { k = { Key.control, Key.shift, Key.o },      c = hl.dsp.exec_cmd "wtype -M shift ] -m shift" },

  { k = { MainMod, Key.numbersign },            c = hl.dsp.workspace.toggle_special("specialwork") },
  { k = { MainMod, Key.shift, Key.numbersign }, c = hl.dsp.window.move { workspace = "special:specialwork", follow = true } },

  { k = { MainMod, WSKey.first },               c = hl.dsp.focus { workspace = "1" } },
  { k = { MainMod, WSKey.second },              c = hl.dsp.focus { workspace = "2" } },
  { k = { MainMod, WSKey.third },               c = hl.dsp.focus { workspace = "3" } },
  { k = { MainMod, WSKey.fourth },              c = hl.dsp.focus { workspace = "4" } },
  { k = { MainMod, WSKey.fifth },               c = hl.dsp.focus { workspace = "5" } },
  { k = { MainMod, WSKey.sixth },               c = function() ws_exec("thunderbird", 6) end },
  { k = { MainMod, WSKey.seventh },             c = hl.dsp.focus { workspace = "7" } },
  { k = { MainMod, WSKey.eigtht },              c = hl.dsp.focus { workspace = "8" } },
  { k = { MainMod, WSKey.ninth },               c = function() ws_exec("vesktop", 9) end },
  { k = { MainMod, WSKey.tenth },               c = hl.dsp.focus { workspace = "10" } },

  { k = { MainMod, Key.f1 },                    c = hl.dsp.focus { workspace = "6" } },
  { k = { MainMod, Key.f2 },                    c = hl.dsp.focus { workspace = "7" } },
  { k = { MainMod, Key.f3 },                    c = hl.dsp.focus { workspace = "8" } },
  { k = { MainMod, Key.f4 },                    c = hl.dsp.focus { workspace = "9" } },

  { k = { MainMod, Key.shift, WSKey.first },    c = hl.dsp.window.move { workspace = "1", follow = true } },
  { k = { MainMod, Key.shift, WSKey.second },   c = hl.dsp.window.move { workspace = "2", follow = true } },
  { k = { MainMod, Key.shift, WSKey.third },    c = hl.dsp.window.move { workspace = "3", follow = true } },
  { k = { MainMod, Key.shift, WSKey.fourth },   c = hl.dsp.window.move { workspace = "4", follow = true } },
  { k = { MainMod, Key.shift, WSKey.fifth },    c = hl.dsp.window.move { workspace = "5", follow = true } },
  { k = { MainMod, Key.shift, WSKey.sixth },    c = hl.dsp.window.move { workspace = "6", follow = true } },
  { k = { MainMod, Key.shift, WSKey.seventh },  c = hl.dsp.window.move { workspace = "7", follow = true } },
  { k = { MainMod, Key.shift, WSKey.eigtht },   c = hl.dsp.window.move { workspace = "8", follow = true } },
  { k = { MainMod, Key.shift, WSKey.ninth },    c = hl.dsp.window.move { workspace = "9", follow = true } },
  { k = { MainMod, Key.shift, WSKey.tenth },    c = hl.dsp.window.move { workspace = "10", follow = true } },

  { k = { MainMod, Key.shift, Key.f1 },         c = hl.dsp.window.move { workspace = "6", follow = true } },
  { k = { MainMod, Key.shift, Key.f2 },         c = hl.dsp.window.move { workspace = "7", follow = true } },
  { k = { MainMod, Key.shift, Key.f3 },         c = hl.dsp.window.move { workspace = "8", follow = true } },
  { k = { MainMod, Key.shift, Key.f4 },         c = hl.dsp.window.move { workspace = "9", follow = true } },

  -- { k = { MainMod, Key.h },                     c = hl.dsp.focus { direction = "l" } },
  -- { k = { MainMod, Key.i },                     c = hl.dsp.focus { direction = "r" } },
  -- { k = { MainMod, Key.e },                     c = hl.dsp.focus { direction = "u" } },
  -- { k = { MainMod, Key.n },                     c = hl.dsp.focus { direction = "d" } },

  { k = { MainMod, Key.h },                     c = hl.dsp.layout "focus l" },
  { k = { MainMod, Key.i },                     c = hl.dsp.layout "focus r" },
  { k = { MainMod, Key.e },                     c = hl.dsp.layout "focus u" },
  { k = { MainMod, Key.n },                     c = hl.dsp.layout "focus d" },

  { k = { MainMod, Key.shift, Key.h },          c = hl.dsp.window.move { direction = "l" } },
  { k = { MainMod, Key.shift, Key.i },          c = hl.dsp.window.move { direction = "r" } },
  { k = { MainMod, Key.shift, Key.e },          c = hl.dsp.window.move { direction = "u" } },
  { k = { MainMod, Key.shift, Key.n },          c = hl.dsp.window.move { direction = "d" } },

  { k = { MainMod, Mouse.click_left },          c = hl.dsp.window.drag(),                                                                                                              r = { mouse = true } },
  { k = { MainMod, Mouse.click_right },         c = hl.dsp.window.resize(),                                                                                                            r = { mouse = true } },

  { k = { MainMod, Mouse.wheel_up },            c = hl.dsp.focus { workspace = "e+1" },                                                                                                r = { mouse = true, repeating = true } },
  { k = { MainMod, Mouse.wheel_down },          c = hl.dsp.focus { workspace = "e-1" },                                                                                                r = { mouse = true, repeating = true } },

  { k = { Key.audio_raise_volume },             c = hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ && ~/.config/hypr/scripts/volume-dunst.sh" },
  { k = { Key.audio_lower_volume },             c = hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && ~/.config/hypr/scripts/volume-dunst.sh" },
  { k = { MainMod, Key.m },                     c = hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/.config/hypr/scripts/volume-dunst.sh" },

  { k = { Key.brightness_up },                  c = hl.dsp.exec_cmd "brightnessctl -e s 2%+" },
  { k = { Key.brightness_down },                c = hl.dsp.exec_cmd "brightnessctl -e s 2%-" },

  { k = { Key.audio_next },                     c = hl.dsp.exec_cmd "playerctl next" },
  { k = { Key.audio_pause },                    c = hl.dsp.exec_cmd "playerctl play-pause" },
  { k = { Key.audio_play },                     c = hl.dsp.exec_cmd "playerctl play-pause" },
  { k = { Key.audio_prev },                     c = hl.dsp.exec_cmd "playerctl previous" },
  { k = { Key.audio_mute },                     c = hl.dsp.exec_cmd "playerctl play-pause" },
  { k = { Key.page_up },                        c = hl.dsp.exec_cmd "~/.config/hypr/scripts/change-sound-output.sh" },
}

for _, v in pairs(binds) do
  hl.bind(table.concat(v.k, " + "), v.c, v.r)
end
