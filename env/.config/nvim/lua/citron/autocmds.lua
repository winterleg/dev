---@diagnostic disable: undefined-global
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local citronGroup = augroup("citron", {})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    if vim.bo.filetype == "" and vim.fn.expand("%:e") == "" then
      vim.bo.filetype = "text"
    end
  end,
})

autocmd('TextYankPost', {
  group = augroup('HighlightYank', {}),
  pattern = '*',
  callback = function()
    vim.hl.on_yank({
      higroup = 'IncSearch',
      timeout = 120,
    })
  end,
})

-- remove trailing whitespaces at the end of a line
autocmd({ "BufWritePre" }, {
  group = citronGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.mp3", "*.mp4" },
  callback = function()
    local file = vim.fn.expand("<afile>")
    vim.fn.jobstart({ "mpv", file }, { detach = true })
    vim.cmd("bdelete!")
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.jpg", "*.png", "*.jpeg", "*.webp" },
  callback = function()
    local file = vim.fn.expand("<afile>")
    vim.fn.jobstart({ "imv", file }, { detach = true })
    vim.cmd("bdelete!")
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local file = vim.fn.expand("<afile>")
    vim.fn.jobstart({ pdfReader, file }, { detach = true })
    vim.cmd("bdelete!")
  end,
})

-- inspired by : https://swnakamura.github.io/posts/vim-japanese-input/
--
-- when InsertLeave, record the status of ime and switch to that when InsertEnter
local last_ime = ""
autocmd("InsertLeave", {
  group = citronGroup,
  pattern = "*",
  callback = function()
    local ok, result = pcall(function()
      return vim.system({ "fcitx5-remote", "-n" }):wait()
    end)

    if ok and result.code == 0 and result.stdout then
      last_ime = vim.trim(result.stdout)
      -- print(last_ime)
    end

    vim.system({ "fcitx5-remote", "-c" })
  end,
})

autocmd("InsertEnter", {
  group = citronGroup,
  pattern = "*",
  callback = function()
    if last_ime ~= "" then
      vim.system({ "fcitx5-remote", "-s", last_ime })
    end
  end,
})

autocmd('LspAttach', {
  group = citronGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lz", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>f", function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client:supports_method("textDocument/formatting") then
          vim.lsp.buf.format()
          return
        end
      end
    end, { desc = "Format the file" })
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>n", function() vim.diagnostic.jump { count = 1 } end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.jump { count = -1 } end, opts)
  end
})

vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    local mode = vim.fn.mode()

    if mode:match("[vV\22]") then
      vim.opt.list = true
    else
      vim.opt.list = false
    end
  end,
})

-- autocmd({ "BufRead", "BufNewFile", "BufWinEnter", "BufEnter" }, {
--   group = citronGroup,
--   callback = function()
--     vim.opt.conceallevel = 2
--     vim.opt.concealcursor = "nivc"
--     vim.fn.matchadd("Conceal", "\\%u202f", 10, -1, {
--       conceal = "⍽",
--     })
--   end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local file_name = vim.fn.expand("%:t")
    if file_name == "Makefile" then
      vim.bo.ft = "make"
    end
  end,
})
