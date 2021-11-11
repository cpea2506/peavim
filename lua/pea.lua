local M = {
	theme = "one_monokai",
	transparent_window = true,
	format_on_save = true,
	yank_highlight = true,

	custom_plugins = {},
	vim_opts = {},
	plugin_opts = {},
	plugins = {},
	autocmd = {},

	keymap = {
		hello = {},
		insert = {},
		visual = {},
	},

	builtin = {
		terminal = {},
		dashboard = {},
		cmp = {},
		null_ls = {
			sources = {},
		},
		lsp = {
			disabled_fmt = {},
		},
	},
}

return M
