_G.vim = vim
_G.pea = require("pea.config.default")

require("pea.config")

pea.utils.func.call_setup({
	"plugins",
	"config.options",
	"utils.autocmd",
	"utils.key_mapping",
}, "pea")

vim.cmd("colorscheme " .. pea.theme)
