local M = {}

local custom = {
	indent_blankline_color = {
		{ "ColorScheme", "*", "hi IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine" },
		{ "ColorScheme", "*", "hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine" },
	},
}

M.setup = function()
	autocmd.define_augroups({ indent_blankline_color = custom.indent_blankline_color })

	require("indent_blankline").setup({
		indent_level = 20,
		max_indent_increase = 1,
		show_trailing_blankline_indent = true,
		use_treesitter = true,
		strict_tabs = true,
		buftype_exclude = { "terminal" },
		filetype_exclude = {
			"help",
			"lsp-installer",
			"packer",
			"toggleterm",
			"NvimTree",
			"dashboard",
			"md",
		},
		space_char_blankline = " ",
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
	})
end

return M
