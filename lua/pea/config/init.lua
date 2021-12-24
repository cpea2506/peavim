require("project_nvim").setup({})
require("numb").setup({
	show_numbers = true, -- Enable 'number' for the window while peeking
	show_cursorline = true, -- Enable 'cursorline' for the window while peeking
	number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
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
