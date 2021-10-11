local M = {}

M.define_augroups = function(definitions) -- {{{1
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	for group_name, definition in pairs(definitions) do
		local cmd = vim.cmd

		cmd("augroup " .. group_name)
		cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd ", def }), " ")
			vim.cmd(command)
		end

		cmd("augroup END")
	end
end

return M
