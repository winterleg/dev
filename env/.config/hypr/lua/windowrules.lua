hl.window_rule { match = { float = true }, rounding = 10 }
hl.window_rule { match = { workspace = "10" }, opacity = "1.0 override" }

hl.window_rule { match = { title = "Minecraft.*" }, render_unfocused = true, immediate = true }
hl.window_rule { match = { class = "overwatch.exe" }, render_unfocused = true, immediate = true }
hl.window_rule { match = { class = "steam_app_2357570" }, render_unfocused = true, immediate = true }
hl.window_rule { match = { class = "forzahorizon.exe" }, render_unfocused = true, immediate = true }

hl.window_rule { match = { class = "steam_app_1551360" }, float = true, persistent_size = true }
hl.window_rule { match = { class = "xdg-desktop-portal-gtk" }, float = true, persistent_size = true }

hl.window_rule { match = { title = "Save.*" }, float = true, size = "1000 700", center = true }

hl.window_rule { match = { pin = true }, border_size = 5, border_color = "rgb(FF0000) rgb(880808)" }

hl.window_rule { match = { class = ".*" }, suppress_event = "maximize" }
hl.window_rule {
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
}
