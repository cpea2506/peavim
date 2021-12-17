local M = {}

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function jumpable(dir)
	local status_luasnip_ok, luasnip = pcall(require, "luasnip")
	if not status_luasnip_ok then
		return
	end

	local win_get_cursor = vim.api.nvim_win_get_cursor
	local get_current_buf = vim.api.nvim_get_current_buf

	local function inside_snippet()
		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1 -- LuaSnip is 0-based not 1-based like nvim for rows
		return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
	end

	local function seek_luasnip_cursor_node()
		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1
		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snippet = node.parent.snippet
		local exit_node = snippet.insert_nodes[0]

		if exit_node then
			local exit_pos_end = exit_node.mark:pos_end()
			if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		node = snippet.inner_first:jump_into(1, true)
		while node ~= nil and node.next ~= nil and node ~= snippet do
			local n_next = node.next
			local next_pos = n_next and n_next.mark:pos_begin()
			local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
				or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

			-- Past unmarked exit node, exit early
			if n_next == nil or n_next == snippet.next then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end

			if candidate then
				luasnip.session.current_nodes[get_current_buf()] = node
				return true
			end

			local ok
			ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
			if not ok then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		-- No candidate, but have an exit node
		if exit_node then
			-- to jump to the exit node, seek to snippet
			luasnip.session.current_nodes[get_current_buf()] = snippet
			return true
		end

		-- No exit node, exit from snippet
		snippet:remove_from_jumplist()
		luasnip.session.current_nodes[get_current_buf()] = nil
		return false
	end

	if dir == -1 then
		return inside_snippet() and luasnip.jumpable(-1)
	else
		return inside_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable()
	end
end

M.setup = function()
	vim.cmd("packadd nvim-cmp")

	local cmp_ok, cmp = pcall(require, "cmp")
	if not cmp_ok then
		return
	end

	local luasnip_ok, luasnip = pcall(require, "luasnip")
	if not luasnip_ok then
		return
	end

	local config = {
		completion = {
			keyword_length = 1,
		},
		confirmation = {
			default_behavior = cmp.ConfirmBehavior.Replace,
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		experimental = {
			ghost_text = true,
			native_menu = false,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "nvim_lua" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "crates" },
		},
		documentation = {
			border = "rounded",
		},
		formatting = {
			format = require("pea.plugins.lsp.lsp_kind").setup({
				menu = {
					path = "[Path]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					buffer = "[Buffer]",
					crates = "[Crates]",
					luasnip = "[Snippet]",
				},
			}),
		},
		mapping = {
			["<C-k>"] = cmp.mapping.scroll_docs(-4),
			["<C-j>"] = cmp.mapping.scroll_docs(4),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif jumpable() then
					luasnip.jump(1)
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<CR>"] = cmp.mapping(cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			})),
			["<C-c>"] = function(fallback)
				cmp.close()
				fallback()
			end,
		},
	}

	require("luasnip.loaders.from_vscode").lazy_load()
	require("cmp").setup(config)
end

return M
