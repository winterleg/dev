-- switch between dwindle and scrolling as of now
function ToggleLayout()
  local current = hl.get_active_workspace()

  if current.tiled_layout == "scrolling" then
    hl.workspace_rule { workspace = current.id, layout = "dwindle" }
    hl.notification.create { text = "Switching to dwindle", duration = 2000 }
  else
    hl.workspace_rule { workspace = current.id, layout = "scrolling" }
    hl.notification.create { text = "Switching to Scrolling", duration = 2000 }
  end
end
