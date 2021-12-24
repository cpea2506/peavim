local M = {}

M.setup = function()
	local actions = require("pea.utils.func").prequire("telescope.actions")

	if not actions then
		return
	end

	local config = {
		defaults = {
			prompt_prefix = "   ",
			selection_caret = " ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "flex",
			layout_config = {
				width = 0.75,
				preview_cutoff = 120,
				horizontal = { mirror = true },
				vertical = { mirror = false },
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-c>"] = actions.close,
					["<CR>"] = actions.select_default + actions.center,
				},
				n = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
				},
				live_grep = {
					--@usage don't include the filename in the search results
					only_sort_text = true,
				},
			},
			border = {},
			winblend = 0,
			use_less = true,
			path_display = {},
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "__pycache__", "node_modules" },
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		},
	}

	require("telescope").setup(config)
	require("telescope").load_extension("projects")
end

return M
