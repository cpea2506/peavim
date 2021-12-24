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

M.setup = function()
	local keymap = {
		normal = {
			["<C-s>"] = ":w<CR>",
			["<Tab>"] = ":BufferNext<CR>",
			["<C-e>"] = ":BufferClose<CR>",
			["<C-b>"] = ":NvimTreeToggle<CR>",
			["<S-Tab>"] = ":BufferPrevious<CR>",
			["<C-p>"] = ":Telescope find_files<CR>",
			["<leader>ft"] = ":lua print(vim.bo.filetype)<CR>",
			["<leader>fo"] = ":lua vim.lsp.buf.formatting_sync()<CR>",
		},
		visual = {
			["<C-s>"] = ":w!<CR>",
		},
	}

	M.set_keymap(keymap)
end

return M
