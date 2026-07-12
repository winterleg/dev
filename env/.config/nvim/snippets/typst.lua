---@diagnostic disable: undefined-global

return {
  s({ trig = "=-", snippetType = "autosnippet" },
    fmta("plus.minus <>", { i(1) })
  ),
  s({ trig = "mt", snippetType = "autosnippet" },
    fmta("$<>$", { i(1) })
  ),
  s({ trig = ";al", snippetType = "autosnippet" },
    fmta("#align(left)[<>]", { i(1) })
  ),
  s({ trig = ";ac", snippetType = "autosnippet" },
    fmta("#align(center)[<>]", { i(1) })
  ),
  s({ trig = ";ar", snippetType = "autosnippet" },
    fmta("#align(right)[<>]", { i(1) })
  ),
  s({ trig = ";d", snippetType = "autosnippet" },
    fmta("(<>)/(<>) <>", {
      i(1),
      i(2),
      i(3)
    })
  ),
  s({ trig = "([^%s]+);f", snippetType = "autosnippet", regTrig = true },
    fmta("<>_(<>)", {
      f(function(_, s) return s.captures[1] end),
      i(1)
    })
  ),
  s({ trig = "([^%s]+);t", snippetType = "autosnippet", regTrig = true },
    fmta("<>^(<>)", {
      f(function(_, s) return s.captures[1] end),
      i(1)
    })
  ),
  s({ trig = "mmt", snippetType = "autosnippet" },
    fmta([[$
  <>
$]], { i(1) })
  )
}
