local config_path = "~/.config/nvim/lua/plugins/config.lua"
local packer_path = "~/.local/share/nvim/site/pack/packer/start"
local num_plugins_loaded = #vim.fn.globpath(packer_path, "*", 0, 1)
local name = "Neovim"
local footer = {
	name .. " loaded " .. num_plugins_loaded .. " plugins ",
	"",
	"Let me show you what is the true text editor!",
	"",
	" 	( ͡° ͜ʖ ͡°)",
}
local func = require("func")

local opts = {
	dashboard_custom_header = {
		" __      __ _               _____             _______           _ ",
		" \\ \\    / /(_)             |  __ \\           |__   __|         (_)",
		"  \\ \\  / /  _   ___  _ __  | |  | |  ___  _ __  | | _ __  __ _  _ ",
		"   \\ \\/ /  | | / _ \\| '_ \\ | |  | | / _ \\| '_ \\ | || '__|/ _` || |",
		"    \\  /   | ||  __/| | | || |__| ||  __/| |_) || || |  | (_| || |",
		"     \\/    |_| \\___||_| |_||_____/  \\___|| .__/ |_||_|   \\__,_||_|",
		"                                         | |                      ",
		"                                         |_|",
	},
	dashboard_custom_section = {
		a = {
			description = { "  Find File          " },
			command = "Telescope find_files",
		},
		b = {
			description = { "  Recently Used Files" },
			command = "Telescope oldfiles",
		},
		c = {
			description = { "  Recent Projects    " },
			command = "Telescope projects",
		},
		d = {
			description = { "  Configuration      " },
			command = { ":e " .. config_path },
		},
	},
	dashboard_custom_footer = func.align_center(footer, 0.5),
}

func.set_plugin_options(opts)

local autocmd = require("autocmd")
autocmd.define_augroups({
	dashboard = {
		{
			"FileType",
			"dashboard",
			"setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
		},
		{
			"FileType",
			"dashboard",
			"set showtabline=0 | autocmd BufLeave <buffer> set showtabline=false",
		},
		{ "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
	},
})
