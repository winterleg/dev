local autostarts = {
  "blueman-applet",
  "nm-applet",
  "ckb-next -b",
  "mpd --no-daemon",
  "dunst",
  "fcitx5",
  -- "~/.config/waybar/waybar.sh",
  "~/.config/hypr/scripts/background-autostart.sh",
  "udiskie --tray",
  "wl-paste --watch cliphist store --no-persist",
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland",
  "dbus-update-activation-environment --systemd --all",
  "systemctl --user import-environment QT_QPA_PLATFORMTHEME",
  "systemctl --user start hyprpolkitagent",
  "dbus-update-activation-environment --all",
  "gnome-keyring-daemon --start --components=secrets,ssh"
}

hl.on("hyprland.start", function()
  for _, v in ipairs(autostarts) do
    hl.exec_cmd(v)
  end
end)
