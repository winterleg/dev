function UpdateMonitors()
  local mons = hl.get_monitors()

  local hasHDMI = false

  for _, value in ipairs(mons) do
    if value.name == "HDMI-A-1" then
      hasHDMI = true
    end
  end
  if hasHDMI then
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
  else
    hl.monitor {
      output   = "eDP-1",
      mode     = "2560x1600@60",
      position = "0x0",
      scale    = "1.25",
    }
  end
  for _, value in ipairs(mons) do
    local name = value.name
    local scale = value.scale
    hl.notification.create { text = "name,scale: " .. name .. "," .. scale, duration = 2000 }
  end
end
