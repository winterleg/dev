hl.workspace_rule { workspace = 1, monitor = "HDMI-A-1", default = true }
hl.workspace_rule { workspace = 2, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 3, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 4, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 5, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 6, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 7, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 8, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 9, monitor = "HDMI-A-1" }
hl.workspace_rule { workspace = 10, monitor = "eDP-1", default = true }

hl.workspace_rule { workspace = "s[1]", gapsout = 50, gapsin = 0, bordersize = 5 }
hl.workspace_rule { workspace = "4", gapsout = 25, gapsin = 0, bordersize = 5 }

hl.window_rule { match = { title = "Minecraft.*" }, workspace = "4" }
hl.window_rule { match = { class = "cs2" }, workspace = "4" }
hl.window_rule { match = { class = "worldofwarships64.exe" }, workspace = "4" }
hl.window_rule { match = { class = "forzahorizon5.exe" }, workspace = "4" }
hl.window_rule { match = { class = "overwatch.exe" }, workspace = "4" }
hl.window_rule { match = { class = "discovery.exe" }, workspace = "4" }
hl.window_rule { match = { class = "ADanceOfFireAndIce" }, workspace = "4" }
hl.window_rule { match = { class = "steam_app.*" }, workspace = "4" }

hl.window_rule { match = { class = "steam" }, workspace = "5" }

hl.window_rule { match = { class = "org.mozilla.Thunderbird" }, workspace = "6" }

hl.window_rule { match = { class = "vesktop" }, workspace = "9" }
hl.window_rule { match = { class = "Element" }, workspace = "9" }

hl.window_rule { match = { title = "^Incrustation vidéo$" }, workspace = "10" }
hl.window_rule { match = { title = "^Picture-in-Picture$" }, workspace = "10" }
