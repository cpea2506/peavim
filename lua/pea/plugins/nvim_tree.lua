local M = {}

local default = {
	vim_setup_opts = {
		nvim_tree_quit_on_open = 1,
	},
	lua_setup_opts = {
		filters = {
			custom = { ".git", ".DS_Store", ".node_modules", ".cache" },
		},
		auto_close = true,
		hijack_cursor = true,
		open_on_setup = true,
		update_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		update_to_buf_dir = {
			auto_open = false,
		},
		view = {
			side = "right",
			auto_resize = true,
		},
	},
}

M.setup = function()
	require("pea.utils.func").set_plugin_options(default.vim_setup_opts)

	require("nvim-tree").setup(default.lua_setup_opts)
end

return M
