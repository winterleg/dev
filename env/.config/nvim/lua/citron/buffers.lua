---@diagnostic disable: undefined-global

vim.pack.add {
  {
    src = 'https://github.com/akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
  }
}

local bufferline = require('bufferline')

bufferline.setup {
  options = {
    indicator = {
      style = "underline",
    },
    diagnostics = "nvim_lsp",
    themable = false,
    diagnostics_indicator = function(count, level, _, _)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end
  }
}

vim.keymap.set("n", "<C-n>", function()
  bufferline.go_to(1, true)
end, { silent = true })
vim.keymap.set("n", "<C-e>", function()
  bufferline.go_to(2, true)
end, { silent = true })
vim.keymap.set("n", "<C-i>", function()
  bufferline.go_to(3, true)
end, { silent = true })
vim.keymap.set("n", "<C-o>", function()
  bufferline.go_to(4, true)
end, { silent = true })

vim.keymap.set('n', '<A-.>', function()
  vim.cmd [[BufferLineMoveNext]]
end, { desc = 'Move buffer right' })

vim.keymap.set('n', '<A-,>', function()
  vim.cmd [[BufferLineMovePrev]]
end, { desc = 'Move buffer left' })

vim.keymap.set("n", "<C-m>", function()
  vim.cmd [[BufferLineCycleNext]]
end)
vim.keymap.set("n", "<C-k>", function()
  vim.cmd [[BufferLineCyclePrev]]
end)
vim.keymap.set("n", "<C-c>", function()
  vim.cmd [[bwipeout!]]
end, { silent = true })
