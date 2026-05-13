require "lua.scripts.monitors"
hl.monitor {
  output   = "HDMI-A-1",
  mode     = "1920x1080@120",
  position = "0x0",
  scale    = "1"
}

hl.monitor {
  output   = "eDP-1",
  mode     = "2560x1600@60",
  position = "auto-left",
  scale    = "2",
}

hl.on("config.reloaded", UpdateMonitors)
hl.on("hyprland.start", UpdateMonitors)
hl.on("monitor.added", UpdateMonitors)
hl.on("monitor.removed", UpdateMonitors)

hl.config {
  xwayland = {
    force_zero_scaling = true
  }
}
