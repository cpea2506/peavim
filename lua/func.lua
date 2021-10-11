local M = {}

M.align_center = function(lines, alignment)
	local output = {}
	local max_len = 0

	for _, line in ipairs(lines) do
		local line_len = #line
		if line_len > max_len then
			max_len = line_len
		end
	end

	for _, line in ipairs(lines) do
		local padding = string.rep(" ", (math.max(0, max_len) - line:len()) * alignment)
		table.insert(output, padding .. line)
	end

	return output
end

M.has_words_before = function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line, col = cursor[1], cursor[2]
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function set_options(scope, opts)
	for opt, value in pairs(opts) do
		scope[opt] = value
	end
end

M.set_vim_options = function(opts)
	local scope = vim.opt
	set_options(scope, opts)
end

M.set_plugin_options = function(opts)
	local scope = vim.g
	set_options(scope, opts)
end

M.call_plugins = function(plugs)
	local plug_dir = "plugins.custom"
	for _, plug in pairs(plugs) do
		require(plug_dir .. "." .. plug)
	end
end

M.plugin_install = function(plugs)
	local packer = require("packer")
	packer.startup({
		function()
			local use = packer.use
			for _, plug in pairs(plugs) do
				use(plug)
			end
		end,
		config = {
			display = {
				open_fn = function()
					return require("packer.util").float({
						style = "minimal",
						border = "rounded",
					})
				end,
			},
			profile = {
				enable = true,
				threshold = 1,
			},
		},
	})
end

M.load_commands = function()
	local autocmd = require("autocmd")

	if pea.transparent_window then
		autocmd.define_augroups({
			transparent_window = {
				{ "ColorScheme", "*", "hi Normal ctermbg=none guibg=none" },
				{ "ColorScheme", "*", "hi clear SignColumn"},
				{"ColorScheme", "*", "hi clear LineNr"},
				{ "ColorScheme", "*", "hi NormalNC ctermbg=none guibg=none" },
				{ "ColorScheme", "*", "hi MsgArea ctermbg=none guibg=none" },
				{ "ColorScheme", "*", "hi TelescopeBorder ctermbg=none guibg=none" },
				{ "ColorScheme", "*", "hi NvimTreeNormal ctermbg=none guibg=none" },
			},
		})
		vim.cmd("let &fcs='eob: '")
	end

	if pea.yank_highlight then
		autocmd.define_augroups({
			yank_highlight = {
				{
					"TextYankPost",
					"*",
					"silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=200})",
				},
			},
		})
	end
end

return M
