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

M.setup = function()
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

	null_ls.config({
		sources = config_source(pea.builtin.null_ls.sources),
	})

	require("lspconfig")["null-ls"].setup({
		on_attach = on_attach,
	})
end

return M
