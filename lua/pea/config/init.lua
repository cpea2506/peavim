pea.plugins = {
	{ "wbthomason/packer.nvim", opt = true },
	{ "mg979/vim-visual-multi", keys = "<C-n>" },
	{ "rafamadriz/friendly-snippets", event = "InsertCharPre" },
	{ "windwp/nvim-ts-autotag", event = "InsertCharPre" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "tami5/lspsaga.nvim" },
	{ "andweeb/presence.nvim" },
	{ "matze/vim-move" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "ahmedkhalf/project.nvim" },
	{ "williamboman/nvim-lsp-installer" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-lua/plenary.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "kyazdani42/nvim-tree.lua" },
	{ "nvim-lualine/lualine.nvim" },
	{ "p00f/nvim-ts-rainbow" },
	{ "nacro90/numb.nvim" },
	{ "myusuf3/numbers.vim" },
	{ "romgrk/barbar.nvim" },
	{ "glepnir/dashboard-nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "ray-x/lsp_signature.nvim" },
	{ "L3MON4D3/LuaSnip" },
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		after = "nvim-lsp-installer",
	},
	{

		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				map_cr = true,
				enable_check_bracket_line = true,
				ignored_next_char = "[%w%.]",
				fast_wrap = {
					map = "<C-w>",
				},
			})
		end,
		event = "InsertCharPre",
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
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

			-- lazygit toggleterm
			_G.lazygit = require("toggleterm.terminal").Terminal:new({
				cmd = "lazygit",
				direction = "float",
				float_opts = {
					border = "rounded",
				},
			})

			pea.utils.key_mapping.set_keymap({
				normal = {
					["<C-g>"] = ":lua lazygit:toggle()<CR>",
				},
			})
		end,
		keys = { "<C-t>", "<C-g>" },
	},
	{
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip", event = "InsertCharPre" },
			{ "hrsh7th/cmp-path", event = "InsertCharPre" },
			{ "hrsh7th/cmp-nvim-lua", ft = "lua", event = "InsertCharPre" },
		},
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("pea.plugins.builtin.crate").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = { "gcc", "gbc", "gc", "gb" },
		config = function()
			require("Comment").setup({
				ignore = "^$", -- ignore empty line
			})

			require("Comment").get_config()
		end,
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
	"stylelint_lsp",
}

pea.transparent_window = true

require("numb").setup({})
require("project_nvim").setup({})
require("telescope").load_extension("projects")

vim.diagnostic.config({
	virtual_text = true,
	underline = false,
	signs = true,
})

require("presence"):setup({
	auto_update = true,
	neovim_image_text = "NeoVim, not Vim pls!",
	main_image = "file",
	client_id = "914799712794705961",
	buttons = true,
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
		["<leader>ft"] = ":lua print(vim.bo.filetype)<CR>",
		["<leader>fo"] = ":lua vim.lsp.buf.formatting_sync()<CR>",
	},
	visual = {
		["<C-s>"] = ":w!<CR>",
	},
}
