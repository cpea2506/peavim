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
pea.builtin.lualine = "evil_lualine"

require("numb").setup({})
require("project_nvim").setup({})

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = true,
	update_in_insert = true,
})

require("presence"):setup({
	auto_update = true,
	neovim_image_text = "NeoVim, not Vim pls!",
	main_image = "file",
	-- 914799712794705961
	client_id = "383226320970055681",
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
