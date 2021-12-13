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

M.list_active_sources = function(filetype, method)
	local info = require("null-ls.info")
	local spec_method = require("null-ls.methods").internal[method]

	local active_sources = info.get_active_sources(filetype)
	return active_sources[spec_method] or {}
end

M.setup = function()
	null_ls.setup({
		sources = config_source(pea.builtin.null_ls.sources),
	})
end

return M
