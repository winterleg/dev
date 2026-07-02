-- switch between dwindle and scrolling as of now

Layout = {
  "dwindle",
  "scrolling"
}

function ToggleLayout()
  local current = hl.get_active_workspace()

  if current == nil then
    return
  end

  if current.tiled_layout == Layout[1] then
    hl.workspace_rule { workspace = current.id, layout = Layout[2] }
    hl.notification.create { text = "Switching to " .. Layout[2], timeout = 2000 }
  else
    hl.workspace_rule { workspace = current.id, layout = Layout[1] }
    hl.notification.create { text = "Switching to " .. Layout[1], timeout = 2000 }
  end
end
