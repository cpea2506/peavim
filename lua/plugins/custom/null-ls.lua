local M = {}

local null_ls = require("null-ls")

local config_source = function(custom_configs)
	local configs = {}

	for _, config in pairs(custom_configs.formatting) do
		local source = config.exe
		local filetypes = config.filetypes

		table.insert(
			configs,
			null_ls.builtins.formatting[source].with({
				filetypes = filetypes,
			})
		)
	end

	for _, config in pairs(custom_configs.diagnostics) do
		local source = config.exe

		table.insert(configs, null_ls.builtins.diagnostics[source])
	end

	return configs
end

M.list_registered_providers_names = function(filetype)
	local u = require("null-ls.utils")
	local c = require("null-ls.config")
	local registered = {}
	for method, source in pairs(c.get()._methods) do
		for name, filetypes in pairs(source) do
			if u.filetype_matches(filetypes, filetype) then
				registered[method] = registered[method] or {}
				table.insert(registered[method], name)
			end
		end
	end
	return registered
end

local list_supported_method = function(type, filetype)
	local null_ls_methods = require("null-ls.methods")
	local method = null_ls_methods.internal[type]
	local registered_providers = M.list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

M.list_supported_formatters_names = function(filetype)
	return list_supported_method("FORMATTING", filetype)
end

M.list_supported_linters_names = function(filetype)
	return list_supported_method("DIAGNOSTICS", filetype)
end

M.setup = function()
	null_ls.config({
		sources = config_source(pea.builtin.null_ls.sources),
	})

	null_ls.register({
		sources = config_source(pea.builtin.null_ls.sources),
	})

	-- format on save
	local on_attach = function(client)
		if pea.format_on_save then
			if client.resolved_capabilities.document_formatting then
				autocmd.define_augroups({
					format_on_save = {
						{
							"BufWritePre",
							"*",
							"lua vim.lsp.buf.formatting_sync()",
						},
					},
				})
			end
		end
	end

	require("lspconfig")["null-ls"].setup({
		on_attach = on_attach,
	})
end

return M
