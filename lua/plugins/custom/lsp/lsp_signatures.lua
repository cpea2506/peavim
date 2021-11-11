local M = {}

M.setup = function()
	require("lsp_signature").setup({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		floating_window = true,
		floating_window_above_cur_line = true,
		fix_pos = true,
		hint_enable = true,
		hint_prefix = "🐼 ",
		hint_scheme = "String",
		use_lspsaga = true,
		hi_parameter = "LspSignatureActiveParameter",
		max_height = 12,

		-- to view the hiding contents
		max_width = 120,
		transpancy = 10,
		always_trigger = false,
		auto_close_after = nil,
		extra_trigger_chars = {},
		zindex = 200,

		padding = "",

		timer_interval = 200,
	})
end

return M
