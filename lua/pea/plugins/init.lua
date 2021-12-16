return {
	setup = function()
		local builtin_plugins = { "lsp", "builtin", "lualine", "packer" }
		local func = pea.utils.func

		func.call_setup(builtin_plugins)
	end,
}
