local plugins_opts = {
	-- space
	mapleader = " ",

	-- neovide
	neovide_cursor_animation_length = 0.12,
	neovide_cursor_vfx_mode = "sonicboom",

	-- vim move
	move_key_modifier = "C",

	-- exclude these from numbers
	numbers_exclude = { "toggleterm", "dashboard", "help", "NvimTree" },

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
	completeopt = { "menu", "menuone", "noselect" },
	lazyredraw = true,
}

local disabled_builtins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

return {
	setup = function()
		-- disable unused builtin plugin
		for _, plugin in pairs(disabled_builtins) do
			vim.g["loaded_" .. plugin] = 1
		end

		local func = pea.utils.func

		local vim_extend = func.extend(vim_opts, pea.vim_opts)
		local plugins_extend = func.extend(plugins_opts, pea.plugins_opts)

		func.set_vim_options(vim_extend)
		func.set_plugins_options(plugins_extend)
	end,
}
