_G.vim = vim -- fixed undefined global `vim` error
_G.func = require("func")

require("config")

local pea = require("pea")

func.set_plugin_options(pea.plugin_opts)
func.set_plugin_options(pea.neovide_opts)
func.plugin_install(pea.plugins)
func.call_plugins(pea.custom_plugins)
