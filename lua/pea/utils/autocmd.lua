local M = {}

local default = {
	packer_on_save = {
		{ "BufWritePost", "init.lua", "PackerInstall" },
		{ "BufWritePost", "init.lua", "PackerCompile" },
	},
}

local default_with_cond = {
	format_on_save = {
		{ "BufWritePre", "*", "lua vim.lsp.buf.formatting_sync()" },
	},
	transparent_window = {
		{ "ColorScheme", "*", "hi Normal guibg=none" },
		{ "ColorScheme", "*", "hi SignColumn guibg=none" },
		{ "ColorScheme", "*", "hi LineNr guibg=none" },
		{ "ColorScheme", "*", "hi CursorLineNr guifg=#abb2bf guibg=none" },
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
		table.insert(autocmd, default_with_cond.format_on_save)
	end

	if pea.transparent_window then
		table.insert(autocmd, default_with_cond.transparent_window)
	end

	if pea.yank_highlight then
		table.insert(autocmd, default_with_cond.yank_highlight)
	end

	for _, cmd in pairs(default) do
		table.insert(autocmd, cmd)
	end

	table.insert(autocmd, pea.autocmd)

	M.load_auto_commands(autocmd)
end

return M
