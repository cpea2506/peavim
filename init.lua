require("pea.utils.func").call_setup({
	"config.default",
	"config.packer",
	"utils.autocmd",
	"utils.key_mapping",
	"plugins",
}, "pea")

require("pea.config")

-- default theme
vim.cmd([[colorscheme one_monokai]])
