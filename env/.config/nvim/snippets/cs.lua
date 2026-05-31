---@diagnostic disable: undefined-global

return {
  s({ trig = "wr" },
    fmta("Console.Write(<>);", { i(1) })
  ),
  s({ trig = "wl" },
    fmta("Console.WriteLine(<>);", { i(1) })
  ),
}
