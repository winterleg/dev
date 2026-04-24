---@diagnostic disable: undefined-global
-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")
--
--


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Monitors/
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/

-- Set programs that you use
local terminal    = "alacritty"
local fileManager = "dolphin"
local menu        = "hyprlauncher"


-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

-- hl.exec_once(terminal)
-- hl.exec_once("nm-applet")
-- hl.exec_once("waybar & hyprpaper & firefox")


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Variables/

-- https://wiki.hypr.land/Configuring/Variables/#general
hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 20,

    border_size      = 2,

    -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
    col              = {
      active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)", angle = 45 } },
      inactive_border = "rgba(595959aa)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
    allow_tearing    = false,

    layout           = "dwindle",
  },
})

-- https://wiki.hypr.land/Configuring/Variables/#decoration
hl.config({
  decoration = {
    rounding         = 10,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    -- https://wiki.hypr.land/Configuring/Variables/#blur
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },
})

-- https://wiki.hypr.land/Configuring/Variables/#animations
hl.config({
  animations = {
    enabled = false,
  },
})

-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    pseudotile     = true,     -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true,     -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
  misc = {
    force_default_wallpaper = -1,        -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = false,     -- If true disables the random hyprland logo / anime girl background. :(
  },
})


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
  input = {
    kb_layout    = "ca",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = 0,     -- -1.0 - 1.0, 0 means no modification.

    touchpad     = {
      natural_scroll = false,
    },
  },
})

-- See https://wiki.hypr.land/Configuring/Gestures/
hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "ALT" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
hl.bind(mainMod .. " + Q", hl.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.window.close())
hl.bind(mainMod .. " + M",
  hl.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + E", hl.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.window.pseudo())
hl.bind(mainMod .. " + J", hl.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
local workspaceKeys = {
  "slash",
  "parenleft",
  "bracketleft",
  "braceleft",
  "apostrophe",
  "dollar",
  "exclam",
  "braceright",
  "bracketright",
  "parenright",
}
for i, key in ipairs(workspaceKeys) do
  hl.bind(mainMod .. " + " .. key, hl.workspace(i))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.workspace({ special = "magic" }))
hl.bind(mainMod .. " + SHIFT + S", hl.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.workspace("e+1"))
hl.bind(mainMod .. " + mouse_up", hl.workspace("e-1"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.exec_cmd("playerctl previous"), { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

-- Example window rules that are useful

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})
