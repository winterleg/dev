hl.config {
  general = {
    gaps_in       = 5,
    gaps_out      = 5,
    border_size   = 0,
    col           = {
      active_border   = 0xFFC4A7E7,
      inactive_border = 0xFF1F1F28,
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

  dwindle = {
    preserve_split = true,
    smart_split    = false,
    force_split    = 2
  },

  scrolling = {
    fullscreen_on_one_column = true,
    direction = "down",
    column_width = 0.95,
    explicit_column_widths = 0.95,
    focus_fit_method = 0
  },

  master = {
    new_status = "master"
  },

  decoration = {
    rounding = 5,

    active_opacity = 1.0,
    inactive_opacity = 0.8,

    dim_special = 0.3,

    shadow = {
      enabled = false
    },

    blur = {
      enabled = false,
      input_methods = true
    }
  },

  animations = {
    enabled = false
  },

  misc = {
    font_family               = "Miracode",
    force_default_wallpaper   = 0,
    disable_hyprland_logo     = true,

    on_focus_under_fullscreen = 1,

    mouse_move_enables_dpms   = true,
    key_press_enables_dpms    = true,
    enable_anr_dialog         = true
  }
}
