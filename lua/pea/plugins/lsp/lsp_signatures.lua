local M = {}

local config = {
	bind = true,
	handler_opts = {
		border = "rounded",
	},
	floating_window = true,
	floating_window_above_cur_line = true,
	hint_enable = true,
	hint_prefix = "🐼 ",
	hint_scheme = "String",
	hi_parameter = "LspSignatureActiveParameter",
	max_height = 12,
	max_width = 150,
	transparency = 10,
	always_trigger = true,
	auto_close_after = 20,
	extra_trigger_chars = { "(", "," },
	zindex = 200,
	padding = "",
	timer_interval = 100,
}

M.setup = function()
	require("lsp_signature").setup(config)
end

return M
