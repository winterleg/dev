---@diagnostic disable: undefined-global
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local citronGroup = augroup("citron", {})

-- remove trailing whitespaces at the end of a line
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		print("BufWritePre")
		vim.cmd([[%s/\s\+$//e]])
	end,
})

autocmd("BufReadCmd", {
	pattern = { "*.jpg", "*.png", "*.jpeg", "*.webp" },
	callback = function()
		local file = vim.fn.expand("<afile>")
		vim.fn.jobstart({ "imv", file }, { detach = true })
		vim.cmd("bdelete!")
	end,
})

autocmd("BufReadCmd", {
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

local group = augroup("CitronFcitx", { clear = true })

local function fcitx_running()
	if vim.fn.executable("fcitx5-remote") == 0 then
		return false
	end

	local result = vim.system(
		{ "fcitx5-remote" },
		{ text = true }
	):wait()

	return result.code == 0
end

if fcitx_running() then
	local last_ime

	autocmd("InsertLeave", {
		group = group,
		callback = function()
			local result = vim.system(
				{ "fcitx5-remote", "-n" },
				{ text = true }
			):wait()

			if result.code == 0 and result.stdout then
				last_ime = vim.trim(result.stdout)
			end

			vim.system(
				{ "fcitx5-remote", "-c" },
				{ text = true }
			):wait()
		end,
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		group = group,
		callback = function()
			if last_ime and last_ime ~= "" then
				vim.system(
					{ "fcitx5-remote", "-s", last_ime },
					{ text = true }
				):wait()
			end
		end,
	})
else
	vim.notify("fcitx5-remote is not running", vim.log.levels.WARN)
end