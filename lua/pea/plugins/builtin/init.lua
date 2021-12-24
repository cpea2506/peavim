return {
	setup = function()
		local builtin = {
			"indent",
			"nvim_tree",
			"crate",
			"telescope",
			"web_devicon",
			"dashboard",
		}

		require("pea.utils.func").call_setup(builtin, "pea.plugins.builtin")
	end,
}
