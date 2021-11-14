local M = {}

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

M.setup = function()
	local func = require("pea.utils.func")

	func.plugin_install(pea.plugins)
	func.call_plugins(builtin_plugins)
end

return M
