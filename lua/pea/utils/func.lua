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

M.extend = function(left, right, ...)
	local another = ... or {}
	return vim.tbl_deep_extend("force", left, right, unpack(another))
end

return M
