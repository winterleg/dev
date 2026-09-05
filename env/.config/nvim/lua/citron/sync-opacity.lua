---@diagnostic disable: undefined-global

local state_file = vim.fn.stdpath("state") .. "/last_opacity"

local default_opacity = 0.86
local current_opacity = default_opacity

local function apply_opacity(val)
	if not vim.g.neovide then return end
	vim.g.neovide_opacity = val
end

local function save_opacity(val)
	current_opacity = val
	vim.fn.writefile({ tostring(val) }, state_file)
end

local function get_opacity_from_file()
	if vim.fn.filereadable(state_file) == 1 then
		local lines = vim.fn.readfile(state_file)
		local val = tonumber(lines[1])
		if val then
			current_opacity = val
			return val
		end
	end
end

local fs_watcher = nil

local function start_fs_watcher()
	if not vim.uv then return end
	if fs_watcher then
		fs_watcher:close()
	end
	fs_watcher = vim.uv.new_fs_event()
	if fs_watcher == nil then
		return
	end
	fs_watcher:start(state_file, {}, function(err)
		if err then return end
		vim.schedule(function()
			if vim.fn.filereadable(state_file) ~= 1 then return end
			local lines = vim.fn.readfile(state_file)
			local val = tonumber(lines[1])
			if not val then return end
			if val == current_opacity then
				return
			end
			current_opacity = val
			apply_opacity(val)
		end)
	end)
end

local function toggle_opacity()
	if current_opacity == default_opacity then
		save_opacity(1)
	else
		save_opacity(default_opacity)
	end
	apply_opacity(current_opacity)
end

local val = get_opacity_from_file()
if val then
	apply_opacity(val)
end

start_fs_watcher()

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if fs_watcher then
			fs_watcher:close()
		end
	end,
})

vim.keymap.set("n", "<leader>tp", toggle_opacity, { desc = "Toggle neovide opacity" })

return {
	toggle = toggle_opacity,
}
