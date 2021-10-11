local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{
			name = "buffer",
			opts = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
				keyword_pattern = [[\k+\]],
			},
		},
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "emoji" },
		{ name = "treesitter" },
		{ name = "crates" },
	},
	documentation = {
		border = "rounded",
	},
	formatting = {
		format = require("lspkind").cmp_format({
			with_text = true,
			menu = {
				crates = "(Crates)",
				emoji = "(Emoji)",
				calc = "(Calc)",
				nvim_lsp = "(LSP)",
				path = "(Path)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
			},
		}),
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif func.has_words_before() then
				cmp.complete()
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
		["<CR>"] = cmp.mapping.confirm(),
	},
})
