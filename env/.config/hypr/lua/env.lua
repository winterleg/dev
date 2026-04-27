local envs = {
  { "XCURSOR_SIZE",                        "24" },
  { "XCURSOR_THEME",                       "BreezeX-RosePine-Linux" },
  { "HYPRCURSOR_SIZE",                     "24" },

  { "LIBVA_DRIVER_NAME",                   "nvidia" },
  { "__GLX_VENDOR_LIBRARY_NAME",           "nvidia" },
  { "NVD_BACKEND",                         "direct" },
  { "GBM_BACKEND",                         "nvidia-drm" },
  { "ELECTRON_OZONE_PLATFORM_HINT",        "auto" },

  { "QT_QPA_PLATFORM",                     "wayland" },
  { "QT_QPA_PLATFORMTHEME",                "qt5ct" },
  { "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
  { "QT_AUTO_SCREEN_SCALE_FACTOR",         "1" },
  { "QT_STYLE_OVERRIDE",                   "kvantum" },

  { "GDK_BACKEND",                         "wayland,x11,*" },
  { "SDL_VIDEODRIVER",                     "wayland,x11" },
  { "CLUTTER_BACKEND",                     "wayland" },

  { "XDG_SESSION_TYPE",                    "wayland" },
  { "XDG_CURRENT_DESKTOP",                 "Hyprland" },
  { "XDG_SESSION_DESKTOP",                 "Hyprland" },
}


for _, v in ipairs(envs) do
  hl.env(v[1], v[2])
end
