require "lua.scripts.layout"

hl.config({
  input      = {
    kb_layout     = "ca",
    -- kb_variant    = ",colemakft",
    -- kb_options    = ",grp:alt_space_toggle",

    follow_mouse  = 1,

    sensitivity   = 0,
    accel_profile = "flat",

    repeat_delay  = 250,
    repeat_rate   = 50,

    touchpad      = {
      natural_scroll       = true,
      disable_while_typing = true
    },
  },

  cursor     = {
    hide_on_key_press    = 1,
    hide_on_tablet       = 0,
    inactive_timeout     = 15,
    zoom_detached_camera = false
  },

  general    = {
    gaps_in       = 0,
    gaps_out      = 0,
    border_size   = 2,
    col           = {
      active_border   = "#62949d",
      inactive_border = "#0d0c13",
    },
    layout        = "manual",
    allow_tearing = true,
    snap          = {
      enabled      = true,
      window_gap   = 10,
      monitor_gap  = 10,
      respect_gaps = true,
    }
  },

  dwindle    = {
    preserve_split        = true,
    smart_split           = true,
    force_split           = 2,
  },

  scrolling  = {
    fullscreen_on_one_column = true,
    direction                = "down",
    column_width             = 1,
    explicit_column_widths   = "0.95, 1",
    focus_fit_method         = 0
  },

  master     = {
    new_status = "master"
  },

  decoration = {
    rounding         = 0,

    active_opacity   = 1.0,
    inactive_opacity = 1.0, -- 0.8,

    dim_special      = 0.3,

    shadow           = {
      enabled = false
    },

    blur             = {
      enabled       = false,
      input_methods = true,
      xray          = true
    },
  },

  animations = {
    enabled = false
  },

  group      = {
    auto_group           = true,
    insert_after_current = true,
    drag_into_group      = 2,

    col                  = {
      border_active   = "#62949d",
      border_inactive = "#0d0c13",
    },

    groupbar             = {
      font_family         = "Comic Code",
      font_size           = 16,
      gradients           = true,
      height              = 18,
      indicator_height    = 0,
      stacked             = false,
      render_titles       = true,
      rounding            = 0,
      gradient_rounding   = 0,
      text_color          = 0xff000000,
      text_color_inactive = 0xffffffff,
      col                 = {
        active   = "#62949d",
        inactive = "#0d0c13",
      },
      gaps_in             = 0,
      gaps_out            = 0,
    }
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
  name   = "wacom-one-by-wacom-m-pen",
  output = "HDMI-A-1",
}
