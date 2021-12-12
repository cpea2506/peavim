local M = {}

local capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	return capabilities
end

local on_attach = function(client, _)
	require("pea.plugins.lsp.lsp_saga").setup() -- for code action,.diagnostics..
	require("pea.plugins.lsp.lsp_signatures").setup()

	for _, server in pairs(pea.builtin.lsp.disable_fmt) do
		if client.name == server then
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end
	end
end

M.setup = function()
	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.on_server_ready(function(server)
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities(),
		}

		if server.name == "rust_analyzer" then
			require("rust-tools").setup({
				server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
			})
			server:attach_buffers()
		elseif server.name == "eslint" then
			local default_opts = server:get_default_options()
			opts.cmd = vim.list_extend({ "yarn", "node" }, default_opts.cmd)
		elseif server.name == "stylelint_lsp" then
			opts.filetypes = { "css", "scss" }
		elseif server.name == "sumneko_lua" then
			local system_name = "macOS"
			local sumneko_root_path = "/Users/CPea2506/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"
			local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"
			opts.cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" }
			opts.settings = {
				Lua = {
					runtime = {
						version = "5.4.3",
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						globals = { "vim", "pea" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
					},
				},
			}
		end

		server:setup(opts)
	end)

	lsp_installer.settings({
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				uninstall_server = "d",
			},
		},
	})
end

return M
