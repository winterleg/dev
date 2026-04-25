---@diagnostic disable: undefined-global

vim.pack.del(
  vim.iter(vim.pack.get())
  :filter(function(x) return not x.active end)
  :map(function(x) return x.spec.name end)
  :totable()
)


print(# vim.iter(vim.pack.get())
  :filter(function(x) return x.active end)
  :totable())
