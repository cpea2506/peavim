pea.plugins = {
	{ "fratajczak/one-monokai-vim" },
	{ "ahmedkhalf/project.nvim" },
	{ "glepnir/dashboard-nvim" },
	{ "rafamadriz/friendly-snippets" },
	{ "wbthomason/packer.nvim" },
	{ "terrortylor/nvim-comment" },
	{ "matze/vim-move" },
	{ "andweeb/presence.nvim" },
	{ "voldikss/vim-floaterm" },
	{ "mg979/vim-visual-multi" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "antoinemadec/FixCursorHold.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{ "kyazdani42/nvim-web-devicons" },
	{
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	},
	{
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"shadmansaleh/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	},

	--|-- lsp stuffs--|--
	{ "kabouzeid/nvim-lspinstall" },
	{ "neovim/nvim-lspconfig" },
	{ "onsails/lspkind-nvim" },
	--|---------------|--

	--|-- tree-sitter stuffs--|--
	{ "nvim-treesitter/nvim-treesitter" },
	{ "windwp/nvim-ts-autotag" },
	{ "windwp/nvim-autopairs" },
	{ "p00f/nvim-ts-rainbow" },
	--|-----------------------|--

	--|-- cmp stuffs--|--
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/nvim-cmp" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-calc" },
	{ "hrsh7th/cmp-emoji" },
	{ "Saecki/crates.nvim" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "ray-x/cmp-treesitter" },
	--|---------------|--

	--|-- number stuffs--|--
	{ "nacro90/numb.nvim" },
	{ "myusuf3/numbers.vim" },
	--|------------------|--
}

-- vim setup
pea.vim_opts = {
	termguicolors = true,
	updatetime = 300,
	cmdheight = 2,
	colorcolumn = "9999",
	foldmethod = "manual",
	guifont = "MesloLGS NF:h11",
	hidden = true,
	completeopt = { "menuone", "noselect" },
	tabstop = 4,
	shiftwidth = 4,
	hlsearch = true,
	smartcase = true,
	smartindent = true,
	autoindent = true,
	clipboard = "unnamedplus",
	undofile = true,
	numberwidth = 2,
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
	showmode = false,
}

-- neovide setup
pea.neovide_opts = {
	neovide_transparency = 0.8,
	neovide_cursor_vfx_mode = "sonicboom",
	neovide_cursor_animation_length = 0.1,
}

-- pea.null_ls = {
-- 	source = {
-- 		formatting = {
-- 			{
-- 				exe = "prettierd",
-- 				with = {},
-- 			},
-- 			{ exe = "black" },
-- 			{ exe = "rustfmt" },
-- 			{ exe = "stylua" },
-- 		},
-- 		diagnostics = {
-- 			{ exe = "flake8" },
-- 			{ exe = "eslint_d" },
-- 			{ exe = "stylelint" },
-- 		},
-- 	},
-- }

-- set keymap
pea.keymap = {
	normal = {
		["<C-s>"] = ":w<CR>",
		["<C-q>"] = ":q<CR>",
		["<C-b>"] = ":NvimTreeToggle<CR>",
		["<Tab>"] = ":BufferNext<CR>",
		["<S-Tab>"] = ":BufferPrevious<CR>",
		["<C-e>"] = ":BufferClose<CR>",
		["<C-t>"] = ":FloatermToggle<CR>",
		["<C-p>"] = ":Telescope find_files<CR>",
	},
	insert = {
		["<C-R>"] = "v:lua.MPairs.autopairs_cr()",
	},
	visual = {
		["<C-s>"] = ":w!<CR>",
	},
}

-- external plugins setup
pea.custom_plugins = {
	"lualine/evil_lualine",
	"dashboard",
	"cmp",
	"null_ls",
	"lsp",
}

-- plugins setup
pea.plugin_opts = {
	-- vim move
	move_key_modifier = "C",

	-- exclude these from numbers
	numbers_exclude = { "nvim_tree", "dashboard" },

	-- nvim-tree
	nvim_tree_quit_on_open = 0,
	nvim_tree_ignore = { ".git", ".DS_Store", ".node_modules", ".cache" },
	nvim_tree_icons = {
		icons = {
			default = "",
			symlink = "",
			git = {
				unstaged = "",
				staged = "S",
				unmerged = "",
				renamed = "➜",
				deleted = "",
				untracked = "U",
				ignored = "◌",
			},
			folder = {
				default = "",
				open = "",
				empty = "",
				empty_open = "",
				symlink = "",
			},
		},
	},
}

require("numb").setup({})
require("nvim_comment").setup({})
require("nvim-autopairs").setup({})
require("telescope").load_extension("projects")

require("presence"):setup({
	main_image = "file",
})

require("nvim-autopairs.completion.cmp").setup({
	map_cr = true,
	map_complete = true,
	auto_select = true,
})

require("nvim-tree").setup({
	auto_close = true,
	open_on_tab = false,
	open_on_setup = false,
	update_focused_file = {
		enable = true,
	},
	view = {
		side = "right",
		auto_resize = true,
		mappings = {
			custom_only = false,
		},
	},
})

require("colorizer").setup({
	"*",
}, {
	RGB = true,
	RRGGBB = true,
	names = false,
	RRGGBBAA = true,
	rgb_fn = true,
	css = true,
	css_fn = true,
})

require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"xml",
		},
	},
	rainbow = {
		enable = true,
		colors = {
			"#FED701",
			"#E492E1",
			"#87CEFA",
			"#FE938C",
			"#A3F7B5",
			"#5A81AC",
			"#D03770",
		},
	},
})
