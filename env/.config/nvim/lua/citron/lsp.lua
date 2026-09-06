---@diagnostic disable: undefined-global
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local citronGroup = augroup("citron", {})


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
	}, { { name = 'buffer' } })
})


vim.lsp.enable({
	"bashls",
	"lua_ls",
	"clangd",
	"ols",
	"tinymist",
	"vimtex",
	"zls",
	"ionide",
	"gopls",
	"haskell-language-server",
	"rust-analyzer",
	"csharp_ls",
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
		if vim.bo[e.buf].filetype ~= "typst" then
			vim.keymap.set("n", "<leader>f", function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				for _, client in ipairs(clients) do
					if client:supports_method("textDocument/formatting") then
						vim.lsp.buf.format()
						return
					end
				end
			end, { buffer = e.buf, desc = "Format the file" })
		end
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set("n", "<leader>n", function() vim.diagnostic.jump { count = 1 } end, opts)
		vim.keymap.set("n", "<leader>e", function() vim.diagnostic.jump { count = -1 } end, opts)
	end
})

