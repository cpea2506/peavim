_G.pea = require("pea")
_G.func = require("func")

require("config")
require("plugins.init")
require("autocmd").setup()
require("key_mapping").setup()

func.set_vim_options(pea.vim_opts)
vim.cmd("colorscheme " .. pea.theme)
