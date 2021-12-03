local plugins_opts = {
	mapleader = " ", -- space

	-- neovide
	neovide_cursor_animation_length = 0.12,
	neovide_cursor_vfx_mode = "sonicboom",

	-- vim move
	move_key_modifier = "C",

	-- exclude these from numbers
	numbers_exclude = { "dashboard", "help" },

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
	guifont = "MesloLGS NF:h20",
	completeopt = { "menuone", "noselect" },
}

return {
	setup = function()
		local func = require("pea.utils.func")

		func.set_vim_options(vim_opts)
		func.set_plugin_options(plugins_opts)

		func.set_vim_options(pea.vim_opts)
		func.set_plugin_options(pea.plugin_opts)
	end,
}
