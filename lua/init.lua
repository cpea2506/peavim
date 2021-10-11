_G.func = require("func")
_G.pea = require("pea")

require("config")
require("plugins/init")


-- PackerCompile on save
	vim.cmd([[
	augroup packercompile_on_save
		autocmd!
		autocmd BufWritePost config.lua PackerCompile
	augroup END
	augroup packerinstall_on_save
		autocmd!
		autocmd BufWritePost config.lua PackerInstall
	augroup END
]])

require("autocmd").define_augroups({
	
})

local keymapping = require("key_mapping")
keymapping.set_keymap(pea.keymap)

-- lua nvim setup
func.load_commands()
func.set_vim_options(pea.vim_opts)
vim.cmd("colorscheme " .. pea.theme)

