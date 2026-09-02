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
	pattern = { "*.mp3", "*.mp4", "*.mkv" },
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

-- に触発された：https://swnakamura.github.io/posts/vim-japanese-input/
--
-- InsertLeave時に時間の除隊を記録し、InsertEnter時にその状態に切り替える

local function fcitx_running()
	if vim.fn.executable("fcitx5-remote") == 0 then
		return false
	end

	local ok, result = pcall(function()
		return vim.system({ "fcitx5-remote" }):wait()
	end)

	return ok and result.code ~= 255
end

if fcitx_running() then
	local last_ime = ""

	autocmd("InsertLeave", {
		group = citronGroup,
		callback = function()
			local result = vim.system({ "fcitx5-remote", "-n" }):wait()

			if result.code == 0 and result.stdout then
				last_ime = vim.trim(result.stdout)
			end

			vim.system({ "fcitx5-remote", "-c" })
		end,
	})

	autocmd("InsertEnter", {
		group = citronGroup,
		callback = function()
			if last_ime ~= "" then
				vim.system({ "fcitx5-remote", "-s", last_ime })
			end
		end,
	})
end

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