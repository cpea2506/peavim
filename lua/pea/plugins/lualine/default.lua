local M = {}

local lualine = require("pea.plugins.lualine")

-- Config
local config = {
	options = {
		icons_enabled = true,
		theme = "onedark",
		disabled_filetypes = { "NvimTree", "dashboard", "toggleterm" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename", "diagnostics", lualine.get_methods_and_server },
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
	require("lualine").setup(config)
end

return M
