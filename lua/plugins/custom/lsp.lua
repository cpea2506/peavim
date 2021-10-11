local lsp_install = require("lspinstall")

local function setup_servers()
	lsp_install.setup({})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local servers = lsp_install.installed_servers()
	for _, server in pairs(servers) do
		require("lspconfig")[server].setup({
			capabilities = capabilities,
		})
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>`
lsp_install.post_install_hook = function()
	setup_servers()
	vim.cmd([[bufdo e]])
end
