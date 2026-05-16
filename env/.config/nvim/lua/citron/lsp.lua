---@diagnostic disable: undefined-global

vim.lsp.enable({
  "bashls",
  "lua_ls",
  "clangd",
  "ols",
  "tinymist",
  "vimtex",
  "c3_lsp",
  "zls",
  "ionide",
  "gopls",
  "haskell-language-server",
  "rust-analyzer",
  "pyright",
  "ocamllsp",
  "clojure-lsp",
})

vim.pack.add {
  { src = "https://github.com/williamboman/mason-lspconfig.nvim", },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp", },
  { src = "https://github.com/hrsh7th/cmp-buffer", },
  { src = "https://github.com/hrsh7th/cmp-path", },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip", },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/hrsh7th/cmp-cmdline", },
  { src = "https://github.com/hrsh7th/nvim-cmp", },
  { src = 'https://github.com/mrcjkb/haskell-tools.nvim',         version = vim.version.range('^9') },
}

local cmp = require "cmp"
cmp.setup({
  experimental = {
    ghost_text = false
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.abort()
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'supermaven' }
  }, { { name = 'buffer' } })
})

vim.diagnostic.config({
  update_in_insert = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = ""
  },
  virtual_text = true
})

vim.pack.add({
  {
    src = 'https://github.com/JavaHello/spring-boot.nvim',
    version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
  },
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/mfussenegger/nvim-dap',

  'https://github.com/nvim-java/nvim-java',
})

require('java').setup()
vim.lsp.enable('jdtls')
