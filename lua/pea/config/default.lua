local M = {}

local plugins_opts = {
	mapleader = " ",

	-- neovide
	neovide_cursor_animation_length = 0.12,
	neovide_cursor_vfx_mode = "sonicboom",

	-- vim move
	move_key_modifier = "C",

	-- exclude these from numbers
	numbers_exclude = { "dashboard", "help", "NvimTree" },

	-- vim visual multi
	VM_mouse_mappings = 1,
}

local vim_opts = {
	hidden = true,
	hlsearch = true,
	swapfile = false,
	smartcase = true,
	smartindent = true,
	autoindent = true,
	undofile = true,
	showmode = false,
	showcmd = false,
	title = true,
	tabstop = 4,
	scrolloff = 8,
	cmdheight = 1,
	shiftwidth = 4,
	numberwidth = 2,
	updatetime = 300,
	sidescrolloff = 8,
	signcolumn = "yes",
	fillchars = "eob: ",
	colorcolumn = "9999",
	foldmethod = "manual",
	clipboard = "unnamedplus",
	guifont = "MesloLGS NF:h11",
	completeopt = { "menuone", "noselect" },
}

M.init = {
	theme = "one_monokai",
	transparent_window = true,
	format_on_save = true,
	yank_highlight = true,
	vim_opts = {},
	plugin_opts = {},
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
		lsp = {
			disabled_fmt = {},
		},
	},
}

M.setup = function()
	local func = require("pea.utils.func")

	func.set_vim_options(vim.list_extend(vim_opts, M.init.vim_opts))
	func.set_plugin_options(vim.list_extend(plugins_opts, M.init.plugin_opts))
end

return M
