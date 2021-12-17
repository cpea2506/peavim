local M = {}

local default = {
	indent_blankline_color = {
		{ "ColorScheme", "*", "hi IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine" },
	},
	crates = {
		{ "ColorScheme", "*", "hi CratesNvimNoMatch guifg=#E06C75 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimError guifg=#f75f5f gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimUpgrade guifg=#E5C07B gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimVersion guifg=#98C379 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPreRelease guifg=#56B6C2 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimYanked guifg=#f75f5f gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimLoading guifg=#C678DD gui=nocombine" },
	},
	popup_crates = {
		{ "ColorScheme", "*", "hi CratesNvimPopupTitle guifg=#E06C75 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPopupVersion guifg=#98C379 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPopupPreRelease guifg=#56B6C2 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPopupYanked guifg=#DA2C43 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPopupFeature guifg=#61AFEF  gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPopupEnabled guifg=#98C379 gui=nocombine" },
		{ "ColorScheme", "*", "hi CratesNvimPopupTransitive guifg=#E06C75 gui=nocombine" },
	},
	packer_on_save = {
		{ "BufWritePost", "init.lua", "source <afile> | PackerInstall" },
		{ "BufWritePost", "init.lua", "source <afile> | PackerCompile" },
	},
}

local default_with_cond = {
	format_on_save = {
		{ "BufWritePre", "*", ":lua vim.lsp.buf.formatting_sync()" },
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
	local autocmd = pea.utils.autocmd

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
		if vim.g.neovide then
			vim.g.one_monokai_no_bg = false
		else
			table.insert(autocmd, default_with_cond.transparent_window)
		end
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
