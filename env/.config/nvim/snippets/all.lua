---@diagnostic disable: undefined-global

EmailPersonnal = ""
EmailUniversity = ""

local file = vim.fn.expand("~/.email")
if vim.fn.filereadable(file) == 1 then
  local lines = vim.fn.readfile(file)
  EmailPersonnal = lines[1]
  EmailUniversity = lines[2]
end

return {
  s({ trig = ";c", snippetType = "autosnippet" },
    t("::")
  ),
  s({ trig = ";e", snippetType = "autosnippet" },
    t(":=")
  ),
  s({ trig = ";t", snippetType = "autosnippet" },
    f(function() return os.date("%Y.%m.%d") end, {})
  ),
  s({ trig = ";h", snippetType = "autosnippet" },
    f(function() return os.date("%H:%M") end, {})
  ),
  s({ trig = ";mp", snippetType = "autosnippet" },
    t(EmailPersonnal)
  ),
  s({ trig = ";mu", snippetType = "autosnippet" },
    t(EmailUniversity)
  ),
  s({ trig = ";[", snippetType = "autosnippet" },
    fmta("\"<>\"", {
      i(1)
    })
  ),
  s({ trig = ";x", snippetType = "autosnippet" },
    fmta("« <> »", {
      i(1)
    })
  ),
}

