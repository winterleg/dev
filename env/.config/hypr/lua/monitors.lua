hl.monitor {
  output   = "HDMI-A-1",
  mode     = "1920x1080@120",
  position = "1280x0",
  scale    = "1"
}

hl.monitor {
  output   = "eDP-1",
  mode     = "2560x1600@60",
  position = "0x0",
  scale    = "2",
}

hl.config {
  xwayland = {
    force_zero_scaling = true
  }
}

-- how can disable and reenabled...
hl.on("monitor.added", function(mon)
  if mon.name == "HDMI-A-1" then
    hl.monitor {
      output = "eDP-1",
      mode   = "2560x1600@60",
      scale  = "2",
    }
  end
end)

hl.on("monitor.removed", function(mon)
  if mon.name == "HDMI-A-1" then
    hl.monitor {
      output = "eDP-1",
      mode   = "2560x1600@165",
      scale  = "1",
    }
  end
end)
