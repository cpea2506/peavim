local M = {
	theme = "one-monokai",
	transparent_window = true,
	format_on_save = true,
	yank_highlight = true,

	custom_plugins = {},
	vim_opts = {},
	plugin_opts = {},
	neovide_opts = {},
	plugins = {},
	autocmd = {},

	keymap = {
		normal = {},
		insert = {},
		visual = {},
	},

	builtin = {
		dashboard = {},
		cmp = {},
		null_ls = {
			sources = {},
		},
	},
}

return M
