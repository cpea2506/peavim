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

local handlers = function()
	local setup = {
		underline = false,
		virtual_text = {
			spacing = 4,
		},
		signs = true,
		update_in_insert = false,
	}

	local handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, setup),
	}

	return handlers
end

M.setup = function()
	local sumneko_root_path = "/Users/CPea2506/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/macOS"
	local sumneko_binary = sumneko_root_path .. "/lua-language-server"
	local sumneko_main = sumneko_root_path .. "/main.lua"

	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	require("lspconfig").sumneko_lua.setup({
		cmd = { sumneko_binary, "-E", sumneko_main },
		settings = {
			Lua = {
				runtime = {
					version = "5.4.3",
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	local lsp_installer = require("nvim-lsp-installer")
	lsp_installer.on_server_ready(function(server)
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities(),
			handlers = handlers(),
		}
		server:setup(opts)
		vim.cmd("do User LspAttachBuffers")
	end)

	lsp_installer.settings({
		ui = {
			icons = {
				server_installed = "✅",
				server_pending = "⏳",
				server_uninstalled = "💀",
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
