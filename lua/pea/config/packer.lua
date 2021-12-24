local plugins = {
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
	{ "ray-x/lsp_signature.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "windwp/nvim-ts-autotag" },
	{ "rafamadriz/friendly-snippets" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "mg979/vim-visual-multi", keys = "<C-n>" },
	{ "wbthomason/packer.nvim" },
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

			require("pea.utils.key_mapping").set_keymap({
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
			{
				"saadparwaiz1/cmp_luasnip",
				after = { "nvim-cmp", "LuaSnip", event = "InsertEnter *" },
			},
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp", event = "InsertEnter *" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp", event = "InsertEnter *" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", ft = "lua", event = "InsertEnter *" },
		},
		config = function()
			require("pea.plugins.lsp.comp").setup()
		end,
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
		config = function()
			require("Comment").setup({
				ignore = "^$", -- ignore empty line
			})
		end,
		keys = { "gc", "gb" },
	},
}

local fn = vim.fn
local runtime_dir = fn.stdpath("data")
local package_root = runtime_dir .. "/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"
local compile_path = fn.stdpath("config") .. "/plugin/packer_compiled.lua"

local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local ok, packer = pcall(require, "packer")

if not ok then
	return
end

packer.init({
	package_root = package_root,
	compile_path = compile_path,
	plugin_package = "packer",
	max_jobs = 50,
	auto_clean = true,
	compile_on_sync = true,
	disable_commands = false,
	opt_default = false,
	transitive_opt = true,
	transitive_disable = true,
	auto_reload_compiled = true,
	git = {
		subcommands = {
			clone_timeout = 300,
			fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
		},
	},
	display = {
		open_fn = function()
			return require("packer.util").float({
				border = "rounded",
			})
		end,
	},
	profile = {
		enable = true,
		threshold = 1,
	},
})

packer.startup(function(use)
	for _, plug in pairs(plugins) do
		use(plug)
	end

	if packer_bootstrap then
		require("packer").sync()
	end
end)
