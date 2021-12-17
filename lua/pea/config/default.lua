return {
	theme = "one_monokai",
	transparent_window = true,
	format_on_save = true,
	yank_highlight = true,
	vim_opts = {},
	plugins_opts = {},
	plugins = {},
	autocmd_opts = {},
	keymap = {
		normal = {},
		insert = {},
		visual = {},
	},
	builtin = {
		dashboard = {},
		null_ls = {
			sources = {},
		},
		lsp = {
			disabled_fmt = {},
		},
		lualine = "evil_lualine",
	},
	utils = require("pea.utils"),
}
