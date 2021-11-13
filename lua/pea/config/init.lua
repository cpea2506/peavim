pea.plugins = {
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "mg979/vim-visual-multi" },
	{ "RishabhRD/popfix" },
	{ "tami5/lspsaga.nvim", branch = "nvim51" },
	{ "andweeb/presence.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "wbthomason/packer.nvim" },
	{ "fratajczak/one-monokai-vim" },
	{ "rafamadriz/friendly-snippets" },
	{ "matze/vim-move" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "antoinemadec/FixCursorHold.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{ "ahmedkhalf/project.nvim" },
	{ "williamboman/nvim-lsp-installer" },
	{ "neovim/nvim-lspconfig" },
	{ "onsails/lspkind-nvim" },
	{ "windwp/nvim-autopairs" },
	{ "p00f/nvim-ts-rainbow" },
	{ "nacro90/numb.nvim" },
	{ "myusuf3/numbers.vim" },
	{ "simrat39/rust-tools.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/playground" },
	{ "ray-x/lsp_signature.nvim" },
	{
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "Saecki/crates.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-calc" },
			{ "ray-x/cmp-treesitter" },
		},
	},
	{
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"glepnir/dashboard-nvim",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				ignore = "^$", -- ignore empty line
			})
			require("Comment").get_config()
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
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	},
}

pea.builtin.null_ls.sources = {
	formatting = {
		{ exe = "prettierd" },
		{ exe = "rustfmt" },
		{ exe = "black" },
		{ exe = "stylua" },
	},
	diagnostics = {
		{ exe = "flake8" },
		{ exe = "eslint_d" },
		{ exe = "stylelint" },
	},
}

-- Some language servers has fomatter on default
-- but it seem didn't work sometimes
-- disabled to use null-ls instead
pea.builtin.lsp.disable_fmt = {
	"rust_analyzer",
	"tsserver",
	"jsonls",
}

require("project_nvim").setup({})
require("numb").setup({})
require("telescope").load_extension("projects")

-- lazygit toggleterm
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	float_opts = {
		border = "rounded",
	},
})

_G.lazygit_toggle = function()
	lazygit:toggle()
end

require("toggleterm").setup({
	hiden_number = true,
	close_on_exit = true,
	shade_terminals = false,
	open_mapping = "<C-t>",
	direction = "float",
	float_opts = {
		windblend = 3,
		border = "rounded",
	},
})

require("presence"):setup({
	main_image = "file",
})

require("nvim-autopairs").setup({
	map_cr = true,
	enable_check_bracket_line = true,
	ignored_next_char = "[%w%.]",
	fast_wrap = {
		map = "<C-w>",
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
			"typescript",
			"typescriptreact",
		},
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		colors = {
			"#e492e1",
			"#fed701",
			"#5a81ac",
			"#fe938c",
			"#a3f7b5",
			"#87cefa",
			"#d03770",
		},
	},
})

-- set keymap
pea.keymap = {
	normal = {
		["<C-s>"] = ":w<CR>",
		["<Tab>"] = ":BufferNext<CR>",
		["<C-e>"] = ":BufferClose<CR>",
		["<C-b>"] = ":NvimTreeToggle<CR>",
		["<S-Tab>"] = ":BufferPrevious<CR>",
		["<C-p>"] = ":Telescope find_files<CR>",
		["<C-g>"] = ":lua lazygit_toggle()<CR>",
		["<leader>gr"] = ":TSHighlightCapturesUnderCursor<CR>",
		["<leader>ft"] = ":lua print(vim.bo.filetype)<CR>",
		["<leader>f"] = ":lua vim.lsp.buf.formatting_sync()<CR>",
	},
	visual = {
		["<C-s>"] = ":w!<CR>",
	},
}
