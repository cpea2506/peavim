local default_opts = {
	wrap = true,
	list = false,
	hidden = true,
	hlsearch = true,
	swapfile = false,
	smartcase = true,
	linebreak = true,
	lazyredraw = true,
	expandtab = true,
	termguicolors = true,
	relativenumber = true,
	smartindent = true,
	autoindent = true,
	showmode = false,
	showcmd = false,
	undofile = true,
	title = true,
	tabstop = 4,
	scrolloff = 8,
	cmdheight = 1,
	shiftwidth = 4,
	numberwidth = 2,
	updatetime = 300,
	sidescrolloff = 8,
	mouse = "a",
	signcolumn = "yes",
	fillchars = "eob: ",
	colorcolumn = "9999",
	foldmethod = "manual",
	clipboard = "unnamedplus",
	guifont = "JetBrainsMonoMedium Nerd Font:h12",
	completeopt = { "menu", "menuone", "noselect" },
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

		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			signs = true,
			update_in_insert = true,
		})

		require("pea.utils.func").set_vim_options(default_opts)
	end,
}
