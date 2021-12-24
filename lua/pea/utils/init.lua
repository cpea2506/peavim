return {
	setup = function()
		local utils_name = {
			"autocmd",
			"key_mapping",
		}

		require("pea.utils.func").call_setup(utils_name, "pea.utils")
	end,
}
