
function Ws_exec(cmd, ws)
  hl.dispatch(hl.dsp.focus { workspace = ws })
  hl.dispatch(hl.dsp.exec_cmd(cmd))
end
