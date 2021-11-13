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

M.set_plugin_options = function(opts)
	local scope = vim.g
	set_options(scope, opts)
end

M.call_plugins = function(plugs)
	local plug_dir = "pea.plugins"
	for _, plug in pairs(plugs) do
		require(plug_dir .. "." .. plug).setup()
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

return M
