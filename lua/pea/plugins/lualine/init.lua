local M = {}

M.get_methods_and_server = function()
	local msg = "Inactive"
	local buf_clients = vim.lsp.buf_get_clients()

	if not next(buf_clients) then
		return msg
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	local null_ls = require("pea.plugins.lsp.null_ls")

	-- add formatter
	local fmt = null_ls.list_active_sources(buf_ft, "FORMATTING")
	vim.list_extend(buf_client_names, fmt)

	-- add linter
	local linter = null_ls.list_active_sources(buf_ft, "DIAGNOSTICS")
	vim.list_extend(buf_client_names, linter)

	return table.concat(buf_client_names, ", ")
end

M.setup = function()
	local theme = "evil_lualine"
	require("pea.plugins.lualine." .. theme).setup()
end

return M
