---@diagnostic disable: undefined-global

local cursorColorForDarkTheme = "#EC5D2A"  -- "#e0def4"
local cursorColorForLightTheme = "#EC5D2A" -- "#21202e"

local state_file = vim.fn.stdpath("state") .. "/last_theme"

local current_name = nil

local saved_bg = nil
local saved_fg = nil

local function fix_visual()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	if normal.fg and normal.bg then
		vim.api.nvim_set_hl(0, "Visual", { fg = normal.bg, bg = normal.fg })
	end
end

local function toggle_black_bg()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	if saved_bg == nil then
		saved_bg = normal.bg
		saved_fg = normal.fg
		vim.api.nvim_set_hl(0, "Normal", { fg = normal.fg, bg = "#000000" })
	else
		vim.api.nvim_set_hl(0, "Normal", { fg = saved_fg, bg = saved_bg })
		saved_bg = nil
		saved_fg = nil
	end
	fix_visual()
end

local function unset_under()
	local groups = {
		"Delimiter",  --
		"DiagnosticUnderlineError", --
		"DiagnosticUnderlineHint", --
		"DiagnosticUnderlineInfo", --
		"DiagnosticUnderlineWarn", --
		"Structure",  --
		"Type",       --
		"TypeDef",    --
		"@lsp",       --
		"@lsp.type.type", --
		"@lsp.type.class", --
		"@lsp.type.struct", --
		"@type",      --
		"DiagnosticUnderlineInfo", --
		"GruvboxBlueUnderline", --
		"@type.builtin", --
	}
	for _, group in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = true })
		hl.underline = false
		hl.undercurl = false
		vim.api.nvim_set_hl(0, group, hl)
	end

	vim.cmd [[highlight typstMarkupHeading cterm=bold gui=bold]]
end

local function save_theme(name)
	saved_bg = nil
	saved_fg = nil

	unset_under()

	if vim.o.background == "dark" then
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = cursorColorForDarkTheme })
		vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = cursorColorForDarkTheme })
	elseif vim.o.background == "light" then
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#FFFFFF", bg = cursorColorForLightTheme })
		vim.api.nvim_set_hl(0, "iCursor", { fg = "#FFFFFF", bg = cursorColorForLightTheme })
	end

	current_name = name

	vim.fn.writefile({ name }, state_file)
end

local function get_theme_from_file()
	if vim.fn.filereadable(state_file) == 1 then
		local lines = vim.fn.readfile(state_file)
		local name = lines[1]
		if name then
			current_name = name
			return name
		end
	end
end

---@class ColorEntry
---@field name string
---@field enabled boolean
---@field callback fun()

---@type ColorEntry[]
local colorsList = {
	{
		name = "miniwinter",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme miniwinter]]

			fix_visual()

			save_theme "miniwinter"
		end,
	},
	{
		name = "Luna",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme lunaperche]]

			fix_visual()

			save_theme "Luna"
		end,
	},
	{
		name = "Vague",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme vague]]

			fix_visual()

			save_theme "Vague"
		end,
	},
	{
		name = "BLUE",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme elflord]]

			fix_visual()

			local hl = vim.api.nvim_get_hl(0, { name = "SpellCap" })
			hl.fg = "#40FFFF"
			vim.api.nvim_set_hl(0, "SpellCap", hl)

			hl = vim.api.nvim_get_hl(0, { name = "SpellBad" })
			hl.fg = "#40FFFF"
			vim.api.nvim_set_hl(0, "SpellBad", hl)

			save_theme "BLUE"
		end,
	},
	{
		name = "Pine",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme rose-pine-main]]

			fix_visual()

			save_theme "Pine"
		end,
	},
	{
		name = "Dawn",
		enabled = true,
		callback = function()
			vim.opt.background = "light"
			vim.cmd [[colorscheme rose-pine-dawn]]

			fix_visual()

			save_theme "Dawn"
		end,
	},
	{
		name = "SURTR",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme surtr]]

			fix_visual()

			save_theme "SURTR"
		end,
	},
	{
		name = "RED",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme mfd-scarlet]]
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2a100a" })
			vim.api.nvim_set_hl(0, "Comment", { fg = "#b94436" })
			vim.api.nvim_set_hl(0, "@comment", { fg = "#b94436" })

			fix_visual()

			save_theme "RED"
		end,
	},
	{
		name = "cat latte",
		enabled = true,
		callback = function()
			vim.opt.background = "light"
			vim.cmd [[colorscheme catppuccin-latte]]

			fix_visual()

			save_theme "cat latte"
		end,
	},
	{
		name = "cat mocha",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme catppuccin-mocha]]

			fix_visual()

			save_theme "cat mocha"
		end,
	},
	{
		name = "CENDRE",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme cendre]]

			fix_visual()

			save_theme "CENDRE"
		end,
	},
	{
		name = "DOS",
		enabled = true,
		callback = function()
			vim.opt.background = "dark"
			vim.cmd [[colorscheme modern-borland]]

			fix_visual()

			save_theme "DOS"
		end,
	},
}

local themes = {}
for _, entry in ipairs(colorsList) do
	if entry.enabled then
		themes[entry.name] = entry.callback
	end
end

local name = get_theme_from_file()
if name then
	if themes[name] then
		vim.cmd("syntax reset")
		unset_under()
		themes[name]()
	end
end

unset_under()

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
			local new_name = lines[1]
			if not new_name then return end
			if new_name == current_name then
				return
			end
			if themes[new_name] then
				current_name = nil

				vim.cmd("syntax reset")
				unset_under()
				themes[new_name]()


				-- local link = zathuraConfigDir .. "/" .. zathuraThemeFile
				-- local target = zathuraConfigDir .. "/" .. (themeToZathura[name] or "t-rosepinedawn")
				-- vim.fn.filecopy(target, link)
			end
		end)
	end)
end

start_fs_watcher()

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if fs_watcher then
			fs_watcher:close()
		end
	end,
})

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function pick_theme()
	local keys = vim.tbl_keys(themes)
	table.sort(keys)

	pickers.new({}, {
		prompt_title = current_name and "Themes - Current: " .. current_name or "Themes",
		finder = finders.new_table {
			results = keys,
		},
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			local function run_selection()
				local entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("syntax reset")
				themes[entry[1]]()
			end
			map("i", "<CR>", run_selection)
			map("n", "<CR>", run_selection)
			return true
		end,
	}):find()
end

vim.keymap.set("n", "<leader>kt", pick_theme, { desc = "Pick theme" })

vim.keymap.set("n", "<leader>kb", toggle_black_bg, { desc = "Toggle black background" })
