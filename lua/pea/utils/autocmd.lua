local M = {}

local default = {
	format_on_save = {
		{
			"BufWritePre",
			"*",
			":lua vim.lsp.buf.formatting_sync()",
		},
	},
	transparent_window = {
		{ "ColorScheme", "*", "hi Normal guibg=none" },
		{ "ColorScheme", "*", "hi SignColumn guibg=none" },
		{ "ColorScheme", "*", "hi  LineNr guibg=none" },
		{ "ColorScheme", "*", "hi CursorLineNr guibg=none" },
		{ "ColorScheme", "*", "hi NormalNC guibg=none" },
		{ "ColorScheme", "*", "hi MsgArea guibg=none" },
		{ "ColorScheme", "*", "hi TelescopeBorder guibg=none" },
		{ "ColorScheme", "*", "hi NvimTreeNormal guibg=none" },
	},
	yank_highlight = {
		{
			"TextYankPost",
			"*",
			"lua vim.highlight.on_yank({higroup='IncSearch', timeout=200})",
		},
	},
	packer_on_save = {
		{
			"BufWritePost",
			"../config/init.lua",
			"PackerInstall",
		},
		{
			"BufWritePost",
			"../*",
			"PackerCompile",
		},
	},
}

M.define_augroups = function(groups)
	local cmd = vim.cmd
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	for name, definitions in pairs(groups) do
		cmd("augroup " .. name)
		cmd("autocmd!")

		for _, def in pairs(definitions) do
			local command = table.concat(vim.tbl_flatten({ "autocmd ", def }), " ")
			cmd(command)
		end
		cmd("augroup END")
	end
end

M.load_auto_commands = function(commands)
	local autocmd = require("pea.utils.autocmd")

	for name, command in pairs(commands) do
		autocmd.define_augroups({
			[name] = command,
		})
	end
end

M.setup = function()
	local autocmd = {}

	if pea.format_on_save then
		table.insert(autocmd, default.format_on_save)
	end

	if pea.transparent_window then
		if vim.g.neovide then
			vim.g.one_monokai_no_bg = false
		else
			table.insert(autocmd, default.transparent_window)
		end
	end

	if pea.yank_highlight then
		table.insert(autocmd, default.yank_highlight)
	end

	table.insert(autocmd, default.packer_on_save)
	table.insert(autocmd, pea.autocmd)

	M.load_auto_commands(autocmd)
end

return M
