local builtin_plugins = {
	"nvim_web_devicon",
	"indent_blankline",
	"dashboard",
	"nvim_tree",
	"lsp",
	"lsp.null_ls",
	"lsp.cmp",
	"lualine.evil_lualine",
}

return {
	setup = function()
		local func = require("pea.utils.func")

		func.call_setup(builtin_plugins)
		func.plugin_install(pea.plugins)
	end,
}
