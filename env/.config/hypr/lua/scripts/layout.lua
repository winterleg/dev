-- switch between master and scrolling as of now
function ToggleLayout()
  local layout = hl.get_config("general.layout")

  if layout == "scrolling" then
    hl.config {
      general = {
        layout = "dwindle"
      }
    }
  else
    hl.config {
      general = {
        layout = "scrolling"
      }
    }
  end
end
