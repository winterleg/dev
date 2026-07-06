---@diagnostic disable: undefined-global

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fs", "fsharp" },
  callback = function()
    local width = 4
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 120
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs", "csharp", "rust", "css", "json", "jsonc" },
  callback = function()
    local width = 4
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 80
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rst" },
  callback = function()
    local width = 2
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "h", "cpp", "cc", "c3" },
  callback = function()
    local width = 2
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c3" },
  callback = function()
    vim.treesitter.start()
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "haskell", "hs", "ocaml" },
  callback = function()
    local width = 2
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typst" },
  callback = function()
    vim.opt_local.textwidth = 72

    vim.opt_local.sidescrolloff = 0

    vim.keymap.set("n", "<leader>h", function()
      local file = vim.fn.expand("%:p")
      vim.system({ "typst", "c", file })
    end, { buffer = true, desc = "Compile Typst file" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "txt" },
  callback = function(args)
    vim.opt_local.sidescrolloff = 0

    vim.opt.wrap                = false

    local width                 = 2
    vim.opt_local.shiftwidth    = width
    vim.opt_local.tabstop       = width
    vim.opt_local.softtabstop   = width
    vim.opt_local.expandtab     = true

    local name                  = vim.api.nvim_buf_get_name(args.buf)
    local tw                    = tonumber(name:match("%.(%d+)%.%w+$"))
    vim.opt_local.textwidth     = tw or 72

    vim.opt_local.autoindent    = false
    vim.opt_local.smartindent   = false
    vim.opt_local.cindent       = false
    vim.opt_local.indentexpr    = ""
    vim.opt_local.indentkeys    = ""
    vim.opt_local.formatoptions = "t"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vimwiki" },
  callback = function()
    vim.opt_local.sidescrolloff = 0

    vim.opt_local.wrap          = false

    local width                 = 2
    vim.opt_local.shiftwidth    = width
    vim.opt_local.tabstop       = width
    vim.opt_local.softtabstop   = width
    vim.opt_local.expandtab     = true

    vim.opt_local.textwidth     = 72

    vim.opt_local.autoindent    = false
    vim.opt_local.smartindent   = false
    vim.opt_local.cindent       = false
    vim.opt_local.indentexpr    = ""
    vim.opt_local.indentkeys    = ""

    vim.opt_local.formatoptions = "t"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "mail", "gitcommit" },
  callback = function()
    vim.opt_local.sidescrolloff = 0

    local width = 8
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = false

    vim.opt_local.textwidth = 72

    vim.opt_local.autoindent = false
    vim.opt_local.smartindent = false
    vim.opt_local.cindent = false
    vim.opt_local.indentexpr = ""
    vim.opt_local.indentkeys = ""
    vim.opt_local.formatoptions = "t"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "md", "markdown", "html" },
  callback = function()

    vim.opt_local.textwidth = 72

    vim.opt_local.sidescrolloff = 0

    local width = 2
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = true
    -- vim.keymap.set("n", "<leader>f", function()
    --   vim.cmd("write")
    --
    --   local file = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    --   vim.cmd("silent !npx prettier " .. file .. " --write")
    --
    --   vim.cmd("edit!")
    -- end, { buffer = true, desc = "Format with Prettier" })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "odin", "go" },
  callback = function()
    -- keep tabs instead of spaces
    vim.opt_local.softtabstop = -1 -- -1 makes it follow shiftwidth or tabstop
    vim.opt_local.expandtab = false
    vim.opt_local.textwidth = 0
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    local width = 2
    vim.opt_local.shiftwidth = width
    vim.opt_local.tabstop = width
    vim.opt_local.softtabstop = width
    vim.opt_local.expandtab = false

    vim.keymap.set("n", "<leader>h", ":w<CR>:!python3 %<CR>", { buffer = true, desc = "Run Python file" })
  end
})
