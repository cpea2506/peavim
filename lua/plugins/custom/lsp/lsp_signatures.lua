local M = {}

local config = {
	bind = false,
	floating_window = false,
	floating_window_above_cur_line = false,
	fix_pos = false,
	hint_enable = true,
	hint_prefix = "🐼 ",
	hint_scheme = "String",
	use_lspsaga = true,
	hi_parameter = "LspSignatureActiveParameter",
	max_height = 12,

	-- to view the hiding contents
	max_width = 120,
	transpancy = 5,
	always_trigger = true,
	auto_close_after = 20,
	extra_trigger_chars = { "(", "," },
	zindex = 200,

	padding = "",

	timer_interval = 200,
}

M.setup = function()
	require("lsp_signature").setup(config)
end

return M
