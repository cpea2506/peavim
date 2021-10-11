local M = {}

M.set_keymap = function(keys)
	local modes = {
		normal = "n",
		insert = "i",
		visual = "v",
	}

	for mode, map in pairs(keys) do
		local key_mode = modes[mode]
		local opts = { noremap = true, silent = true }

		for key, value in pairs(map) do
			vim.api.nvim_set_keymap(key_mode, key, value, opts)
		end
	end
end

return M
