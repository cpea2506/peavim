local M = {}

---@diagnostic disable-next-line: unused-local, lowercase-global
doc_scroll_up = function()
	require("lspsaga.action").smart_scroll_with_saga(-1)
end

---@diagnostic disable-next-line: unused-local, lowercase-global
doc_scroll_down = function()
	require("lspsaga.action").smart_scroll_with_saga(1)
end

local key_map = {
	normal = {
		["<C-u>"] = ":lua doc_scroll_up()<CR>",
		["<C-d>"] = ":lua doc_scroll_down()<CR>",
		["<leader>gh"] = ":Lspsaga lsp_finder<CR>",
		["<leader>de"] = ":Lspsaga preview_definition<CR>",
		["<leader>da"] = ":Lspsaga show_line_diagnostics<CR>",
		["<leader>do"] = ":Lspsaga hover_doc<CR>",
		["<leader>rn"] = ":Lspsaga rename<CR>",
		["<leader>ca"] = ":Lspsaga code_action<CR>",
	},
}

M.setup = function()
	local saga = require("lspsaga")

	saga.setup({
		use_saga_diagnostic_sign = true,
		error_sign = "",
		warn_sign = "",
		hint_sign = "",
		infor_sign = "",
		diagnostic_header_icon = "   ",
		code_action_icon = " ",
		code_action_prompt = {
			enable = true,
			sign = true,
			sign_priority = 40,
			virtual_text = true,
		},
		finder_definition_icon = "  ",
		finder_reference_icon = "  ",
		max_preview_lines = 10,
		finder_action_keys = {
			open = "o",
			vsplit = "s",
			split = "i",
			quit = "q",
			scroll_down = "<C-j>",
			scroll_up = "<C-k>",
		},
		code_action_keys = {
			quit = "q",
			exec = "<CR>",
		},
		rename_action_keys = {
			quit = "<C-c>",
			exec = "<CR>",
		},
		definition_preview_icon = "  ",
		border_style = "round",
		rename_prompt_prefix = "➤",
	})

	pea.utils.key_mapping.set_keymap(key_map)
end

return M
