_G.vim = vim
_G.pea = require("pea.config.default").init

require("pea.config")
require("pea.plugins")

require("pea.utils.autocmd").setup()
require("pea.utils.key_mapping").setup()

vim.cmd("colorscheme " .. pea.theme)
