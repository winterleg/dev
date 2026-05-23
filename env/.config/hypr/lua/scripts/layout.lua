-- switch between master and scrolling as of now
function ToggleLayout()
  local current = hl.get_active_workspace()

  if current.tiled_layout == "scrolling" then
    hl.workspace_rule { workspace = current.id, layout = "dwindle" }
  else
    hl.workspace_rule { workspace = current.id, layout = "scrolling" }
  end
end
