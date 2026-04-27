hl.config({
  input = {
    kb_layout     = "ca",

    follow_mouse  = 1,

    sensitivity   = 0,
    accel_profile = "flat",

    touchpad      = {
      natural_scroll = true
    }
  }
})

hl.device {
  name = "wacom-one-by-wacom-m-pen",
  output = "HDMI-A-1",
  enabled = true,
}

hl.device {
  name = "elan06fa:00-04f3:327e-touchpad",
  enabled = true
}

hl.cursor {
  hide_on_key_press = 1,
  hide_on_tablet = 0,
  inactive_timeout = 15,
}
