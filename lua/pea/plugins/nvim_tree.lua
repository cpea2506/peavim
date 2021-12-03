local M = {}

local default = {
	vim_setup_opts = {
		vim_tree_git_hl = 1,
		nvim_tree_quit_on_open = 1,
		nvim_tree_show_icons = {
			git = 1,
			folders = 1,
			files = 1,
			folder_arrows = 1,
		},
		nvim_tree_icons = {
			default = "",
			symlink = "",
			git = {
				unstaged = "✗",
				staged = "✓",
				unmerged = "",
				renamed = "➜",
				untracked = "★",
				deleted = "",
			},
			folder = {
				arrow_open = "",
				arrow_closed = "",
				default = "",
				open = "",
				empty = "",
				empty_open = "",
				symlink = "",
				symlink_open = "",
			},
			lsp = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
	},
	lua_setup_opts = {
		disable_netrw = true,
		hijack_netrw = true,
		open_on_tab = false,
		auto_close = true,
		hijack_cursor = true,
		open_on_setup = true,
		update_cwd = true,
		filters = {
			dotfiles = true,
			custom = { ".git", ".DS_Store", "node_modules", ".cache" },
		},
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		update_to_buf_dir = {
			enable = true,
			auto_open = true,
		},
		view = {
			side = "right",
			auto_resize = true,
			number = false,
			relativenumber = false,
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
	},
}

M.setup = function()
	require("pea.utils.func").set_plugin_options(default.vim_setup_opts)

	require("nvim-tree").setup(default.lua_setup_opts)
end

return M
