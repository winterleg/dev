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
  s({ trig = ";t", snippetType = "autosnippet" },
    t(os.date("%Y.%m.%d"))
  ),
  s({ trig = ";h", snippetType = "autosnippet" },
    t(os.date("%H:%M"))
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
