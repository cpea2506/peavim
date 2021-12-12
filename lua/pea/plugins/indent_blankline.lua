local M = {}

M.setup = function()
	require("indent_blankline").setup({
		indent_level = 10,
		max_indent_increase = 1,
		show_trailing_blankline_indent = false,
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
