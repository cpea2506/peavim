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

M.prequire = function(module)
	local msgh = function()
		return "Module " .. module .. " not found..."
	end

	local ok, err = xpcall(require, msgh, module)

	if not ok then
		error(("Error loading %s...\n\n%s"):format(module, err))
		return nil, err
	end

	return err
end

M.call_setup = function(modules, dir)
	local setup_dir = dir or "pea.plugins"

	for _, module in pairs(modules) do
		local mod_dir = setup_dir .. "." .. module
		local mod = M.prequire(mod_dir)

		if mod then
			mod.setup()
		end
	end
end

M.extend = function(left, right)
	return vim.tbl_deep_extend("force", left, right)
end

M.plugin_install = function(plugs)
	vim.cmd("packadd packer.nvim")
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
