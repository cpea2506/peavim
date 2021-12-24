local M = {}

local config = {
	packer_on_save = {
		{ "BufWritePost", "init.lua", "PackerInstall" },
		{ "BufWritePost", "init.lua", "PackerCompile" },
	},
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
	M.load_auto_commands(config)
end

return M
