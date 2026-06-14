function Focus_fs(direction)
  local active = hl.get_active_window()

  if active ~= nil and active.fullscreen ~= 0 then
    hl.dispatch(hl.dsp.layout("focus " .. direction))
  end
  hl.dispatch(hl.dsp.focus { direction = direction })
end
