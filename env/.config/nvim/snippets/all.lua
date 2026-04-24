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
  s("date", t(os.date("%Y/%m/%d"))),
  s("time", t(os.date("%H:%M"))),
  s("mailp", t(EmailPersonnal)),
  s("mailu", t(EmailUniversity)),
}
