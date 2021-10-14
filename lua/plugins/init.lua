_G.vim = vim -- fixed undefined global `vim` error
_G.func = require("func")
_G.autocmd = require("autocmd")
require("config")

func.plugin_install(pea.plugins)
func.set_plugin_options(pea.plugin_opts)
func.set_plugin_options(pea.neovide_opts)
func.call_plugins(pea.custom_plugins)
