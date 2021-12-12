local builtin_plugins = {
	"lsp",
	"lsp.cmp",
	"lsp.null_ls",
	"builtin.dashboard",
	"builtin.nvim_tree",
	"builtin.indent_blankline",
	"builtin.nvim_web_devicon",
	"lualine.evil_lualine",
}

return {
	setup = function()
		local func = pea.utils.func

		func.call_setup(builtin_plugins)
		func.plugin_install(pea.plugins)
	end,
}
