local M = {}

M.setup = function()
	local plugins = {
		"dashboard",
		"nvim_tree",
		"indent_blankline",
		"nvim_web_devicon",
	}

	pea.utils.func.call_setup(plugins, "pea.plugins.builtin")
end

return M
