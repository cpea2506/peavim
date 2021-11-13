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
		server:setup(opts)
		vim.cmd("do User LspAttachBuffers")
	end)

	lsp_installer.settings({
		ui = {
			icons = {
				server_installed = "🍀",
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
