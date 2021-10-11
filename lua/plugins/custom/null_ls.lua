local null_ls = require("null-ls")
local pea = require("pea")

local config_source = function(custom_configs)
	local configs = {}

	for _, type in pairs(custom_configs) do
		for _, config in pairs(type) do
			local source = config.exe
			local opts = config.with and config.with or {}

			if type == "formatting" then
				table.insert(configs, null_ls.builtins.formatting[source].with(opts))
			else
				table.insert(configs, null_ls.builtins.diagnostics[source].with(opts))
			end
		end
	end

	return configs
end

null_ls.config({
	sources = config_source(pea.null_ls.source),
})

-- format on save
local on_attach = function(client)
	if pea.transparent_window then
		if client.resolved_capabilities.document_formatting then
			require("autocmd").define_augroups({
				format_on_save = {
					"BufWritePre",
					"*",
					"lua vim.lsp.buf.formatting_sync()",
				},
			})
		end
	end
end

require("lspconfig")["null-ls"].setup({
	on_attach = on_attach,
})
