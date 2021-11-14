_G.vim = vim
_G.pea = require("pea.config.default")

require("pea.config")

require("pea.utils.func").call_setup({
	"config.options",
	"plugins",
	"utils.autocmd",
	"utils.key_mapping",
}, "pea")

vim.cmd("colorscheme " .. pea.theme)
