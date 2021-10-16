local M = {}

local lualine = require("lualine")

local get_servers_and_methods = function()
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

	local null_ls = require("plugins.custom.lsp.null-ls")

	-- add formatter
	local supported_formatters = null_ls.list_supported_formatters_names(buf_ft)
	vim.list_extend(buf_client_names, supported_formatters)

	-- add linter
	local supported_linters = null_ls.list_supported_linters_names(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)

	return table.concat(buf_client_names, ", ")
end
-- Config
local config = {
	options = { icons_enabled = true, theme = "onedark", disabled_filetypes = { "NvimTree", "dashboard" } },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename", "diagnostics", get_servers_and_methods },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "dif", "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
}

-- Now don't forget to initialize lualine
M.setup = function()
	lualine.setup(config)
end

return M
