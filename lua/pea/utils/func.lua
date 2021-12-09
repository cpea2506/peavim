local M = {}

local set_options = function(scope, opts)
	for opt, value in pairs(opts) do
		scope[opt] = value
	end
end

M.set_vim_options = function(opts)
	local scope = vim.opt
	set_options(scope, opts)
end

M.set_plugins_options = function(opts)
	local scope = vim.g
	set_options(scope, opts)
end

M.call_setup = function(modules, dir)
	local setup_dir = dir or "pea.plugins"

	for _, module in pairs(modules) do
		require(setup_dir .. "." .. module).setup()
	end
end

M.extend = function(left, right)
	return vim.tbl_extend("force", left, right)
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

return M
