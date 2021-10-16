pea.plugins = {
	{ "andweeb/presence.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "wbthomason/packer.nvim" },
	{ "fratajczak/one-monokai-vim" },
	{ "rafamadriz/friendly-snippets" },
	{ "matze/vim-move" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "antoinemadec/FixCursorHold.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "windwp/nvim-ts-autotag" },
	{ "ahmedkhalf/project.nvim" },
	{ "kabouzeid/nvim-lspinstall" },
	{ "neovim/nvim-lspconfig" },
	{ "onsails/lspkind-nvim" },
	{ "windwp/nvim-autopairs" },
	{ "p00f/nvim-ts-rainbow" },
	{ "nacro90/numb.nvim" },
	{ "myusuf3/numbers.vim" },
	{
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "Saecki/crates.nvim" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-calc" },
			{ "hrsh7th/cmp-emoji" },
			{ "ray-x/cmp-treesitter" },
		},
	},
	{
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"glepnir/dashboard-nvim",
		config = function()
			require("plugins.custom.dashboard").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
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
}

-- vim setup
pea.vim_opts = {
	termguicolors = true,
	updatetime = 300,
	cmdheight = 2,
	colorcolumn = "9999",
	foldmethod = "manual",
	guifont = "MesloLGS NF:h12",
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
	neovide_transparency = 0.85,
	neovide_cursor_vfx_mode = "sonicboom",
	neovide_cursor_animation_length = 0.1,
}

pea.builtin.null_ls.sources = {
	formatting = {
		{
			exe = "prettierd",
			filetypes = {
				"css",
			},
		},
		{ exe = "black" },
		{ exe = "rustfmt" },
		{ exe = "stylua" },
	},
	diagnostics = {
		{ exe = "flake8" },
		{ exe = "eslint_d" },
		{ exe = "stylelint" },
	},
}

-- set keymap
pea.keymap = {
	normal = {
		["<C-s>"] = ":w<CR>",
		["<C-b>"] = ":NvimTreeToggle<CR>",
		["<C-p>"] = ":Telescope find_files<CR>",
		["<C-g>"] = ":lua lazygit_toggle()<CR>",
		["<C-e>"] = ":BufferClose<CR>",
		["<Tab>"] = ":BufferNext<CR>",
		["<S-Tab>"] = ":BufferPrevious<CR>",
	},
	visual = {
		["<C-s>"] = ":w!<CR>",
	},
}

-- external plugins setup
pea.custom_plugins = {
	"lualine/evil_lualine",
	"lsp",
}

-- plugins setup
pea.plugin_opts = {
	-- vim move
	move_key_modifier = "C",

	-- exclude these from numbers
	numbers_exclude = { "dashboard", "help", "toggleterm", "NvimTree" },

	-- nvim-tree
	nvim_tree_quit_on_open = 1,
	nvim_tree_ignore = { ".git", ".DS_Store", ".node_modules", ".cache" },
	bufferline = {
		animation = true,
		tabpages = true,
		closable = true,
		clickable = true,
		icons = true,
		icon_separator_active = "▎",
		icon_separator_inactive = "▎",
		icon_close_tab = "",
		icon_close_tab_modified = "●",
		icon_pinned = "車",
	},
}

require("plugins.custom.cmp").setup()
require("plugins.custom.null-ls").setup()
require("telescope").load_extension("projects")
require("nvim-autopairs").setup({})
require("project_nvim").setup({})
require("numb").setup({})

-- lazygit toggleterm
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
	float_opts = {
		border = "rounded",
	},
})

_G.lazygit_toggle = function()
	lazygit:toggle()
end

require("toggleterm").setup({
	direction = "horizontal",
	size = 15,
	shade_terminals = false,
	persist_size = true,
	close_on_exit = true,
	open_mapping = "<C-t>",
})

require("presence"):setup({
	main_image = "file",
})

require("nvim-autopairs.completion.cmp").setup({
	map_cr = true,
	map_complete = true,
	auto_select = true,
})

require("nvim-tree").setup({
	ignore_ft_on_setup = {
		"dashboard",
	},
	auto_close = true,
	open_on_tab = false,
	open_on_setup = false,
	update_focused_file = {
		enable = true,
	},
	update_to_buf_dir = {
		enable = true,
		update_cwd = true,
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
