local M = {}

local default = {
	format_on_save = {
		{
			"BufWritePre",
			"*",
			"lua vim.lsp.buf.formatting_sync()",
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
			"silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=200})",
		},
	},
	packer_on_save = {
		{
			"BufWritePost",
			"config.lua",
			"PackerInstall",
		},
		{
			"BufWritePost",
			"config.lua",
			"PackerCompile",
		},
	},
}

M.define_augroups = function(definitions)
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	for group_name, definition in pairs(definitions) do
		local cmd = vim.cmd

		cmd("augroup " .. group_name)
		cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd ", def }), " ")
			cmd(command)
		end

		cmd("augroup END")
	end
end

M.load_auto_commands = function(commands)
	local autocmd = require("autocmd")

	for name, command in pairs(commands) do
		autocmd.define_augroups({
			[name] = command,
		})
	end
end

M.setup = function()
	if pea.format_on_save then
		autocmd.define_augroups({ format_on_save = default.format_on_save })
	end

	if pea.transparent_window then
		if vim.g.neovide then
			vim.g.one_monokai_no_bg = false
		else
			M.define_augroups({ transparent_window = default.transparent_window })
		end
	end

	if pea.yank_highlight then
		M.define_augroups({ yank_highlight = default.yank_highlight })
	end

	M.define_augroups({ packer_on_save = default.packer_on_save })

	M.load_auto_commands(pea.autocmd)
end

return M
