hl.config({
  input      = {
    kb_layout     = "ca",

    follow_mouse  = 1,

    sensitivity   = 0,
    accel_profile = "flat",

    repeat_delay  = 250,

    touchpad      = {
      natural_scroll       = true,
      disable_while_typing = true
    },
  },

  cursor     = {
    hide_on_key_press = 1,
    hide_on_tablet    = 0,
    inactive_timeout  = 15,
  },

  general    = {
    gaps_in       = 0,
    gaps_out      = 0,
    border_size   = 0,
    col           = {
      active_border   = 0xFFb8bb26,
      inactive_border = 0xFF83a598,
    },
    layout        = "scrolling",
    allow_tearing = true,

    snap          = {
      enabled      = true,
      window_gap   = 10,
      monitor_gap  = 10,
      respect_gaps = true,
    }
  },

  dwindle    = {
    preserve_split = true,
    smart_split    = false,
    force_split    = 2
  },

  scrolling  = {
    fullscreen_on_one_column = true,
    direction                = "down",
    column_width             = 1,
    explicit_column_widths   = 1,
    focus_fit_method         = 0
  },

  master     = {
    new_status = "master"
  },

  decoration = {
    rounding         = 0,

    active_opacity   = 1.0,
    inactive_opacity = 0.8,

    dim_special      = 0.3,

    shadow           = {
      enabled = false
    },

    blur             = {
      enabled       = false,
      input_methods = true
    }
  },

  animations = {
    enabled = false
  },

  misc       = {
    font_family               = "Miracode",
    force_default_wallpaper   = 0,
    disable_hyprland_logo     = true,

    on_focus_under_fullscreen = 1,

    mouse_move_enables_dpms   = true,
    key_press_enables_dpms    = true,
    enable_anr_dialog         = true
  }
})

hl.device {
  name    = "wacom-one-by-wacom-m-pen",
  output  = "HDMI-A-1",
}

-- hl.device {
--   name    = "elan06fa:00-04f3:327e-touchpad",
--   enabled = true
-- }
