return {
	setup = function()
		local func = require("pea.utils.func")

		local opts = {
			-- space
			mapleader = " ",

			-- neovide
			neovide_cursor_animation_length = 0.12,
			neovide_cursor_vfx_mode = "sonicboom",
			neovide_transparency = 0.75,

			-- vim move
			move_key_modifier = "C",

			-- exclude these from numbers
			numbers_exclude = { "lsp-installer", "toggleterm", "dashboard", "help", "NvimTree" },

			-- vim visual multi
			VM_mouse_mappings = 1,
		}

		local builtin_plugins = { "builtin", "lsp", "lualine" }

		func.call_setup(builtin_plugins)
		func.set_plugins_options(opts)
	end,
}
