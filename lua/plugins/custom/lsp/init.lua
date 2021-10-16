local M = {}

M.setup = function()
	local lsp_installer = require("nvim-lsp-installer")

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	lsp_installer.on_server_ready(function(server)
		local opts = { capabilities = capabilities }

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
				uninstall_server = "X",
			},
		},
	})
end

return M
