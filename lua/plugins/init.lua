_G.vim = vim -- fixed undefined global `vim` error
_G.func = require("func")
_G.autocmd = require("autocmd")

func.set_plugin_options(pea.plugin_opts)
func.plugin_install(pea.plugins)
func.call_plugins(pea.custom_plugins)
