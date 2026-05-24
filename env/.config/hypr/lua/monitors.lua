require "lua.scripts.monitors"

hl.on("config.reloaded", UpdateMonitors)
hl.on("hyprland.start", UpdateMonitors)
hl.on("monitor.added", UpdateMonitors)
hl.on("monitor.removed", UpdateMonitors)

hl.config {
  xwayland = {
    force_zero_scaling = true
  }
}
