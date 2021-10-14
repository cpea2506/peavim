local M = {}

local default = {
	transparent_window = {
		{ "ColorScheme", "*", "hi Normal ctermbg=none guibg=none" },
		{ "ColorScheme", "*", "hi clear SignColumn" },
		{ "ColorScheme", "*", "hi clear LineNr" },
		{ "ColorScheme", "*", "hi NormalNC ctermbg=none guibg=none" },
		{ "ColorScheme", "*", "hi MsgArea ctermbg=none guibg=none" },
		{ "ColorScheme", "*", "hi TelescopeBorder ctermbg=none guibg=none" },
		{ "ColorScheme", "*", "hi NvimTreeNormal ctermbg=none guibg=none" },
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
			"PackerCompile",
		},
		{
			"BufWritePost",
			"config.lua",
			"PackerInstall",
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
			name = command,
		})
	end
end

M.setup = function()
	if pea.transparent_window then
		M.define_augroups({ transparent_window = default.transparent_window })
		vim.cmd("let &fcs='eob: '")
	end

	if pea.yank_highlight then
		M.define_augroups({ yank_highlight = default.yank_highlight })
	end

	M.define_augroups({ packer_on_save = default.packer_on_save })

	M.load_auto_commands(pea.autocmd)
end

return M
