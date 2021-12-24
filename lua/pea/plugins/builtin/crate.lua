local M = {}

M.setup = function()
	require("pea.utils.key_mapping").set_keymap({
		normal = {
			["K"] = [[:lua require("crates").show_versions_popup()<CR>]],
			["F"] = [[:lua require("crates").show_features_popup()<CR>]],
		},
	})

	vim.cmd("packadd crates.nvim")
	require("crates").setup({
		smart_insert = true,
		avoid_prerelease = true,
		autoload = true,
		autoupdate = true,
		loading_indicator = true,
		date_format = "%Y-%m-%d",
		text = {
			loading = "   Loading",
			version = "   %s",
			prerelease = "   %s",
			yanked = "   %s",
			nomatch = "   No match",
			upgrade = "   %s",
			error = "   Error fetching crate",
		},
		highlight = {
			loading = "CratesNvimLoading",
			version = "CratesNvimVersion",
			prerelease = "CratesNvimPreRelease",
			yanked = "CratesNvimYanked",
			nomatch = "CratesNvimNoMatch",
			upgrade = "CratesNvimUpgrade",
			error = "CratesNvimError",
		},
		popup = {
			autofocus = true,
			copy_register = '"',
			style = "minimal",
			border = "rounded",
			version_date = false,
			max_height = 30,
			min_width = 20,
			text = {
				title = "  %s ",
				version = "   %s ",
				prerelease = "  %s ",
				yanked = "  %s ",
				date = " %s ",
				feature = "   %s ",
				enabled = "  %s ",
				transitive = "  %s ",
			},
			highlight = {
				title = "CratesNvimPopupTitle",
				version = "CratesNvimPopupVersion",
				prerelease = "CratesNvimPopupPreRelease",
				yanked = "CratesNvimPopupYanked",
				feature = "CratesNvimPopupFeature",
				enabled = "CratesNvimPopupEnabled",
				transitive = "CratesNvimPopupTransitive",
			},
			keys = {
				hide = { "q", "<ESC>" },
				select = { "<CR>" },
				select_alt = { "s" },
				copy_version = { "yy" },
				toggle_feature = { "<CR>" },
				goto_feature = { "gd", "K" },
				jump_forward_feature = { "<C-i>" },
				jump_back_feature = { "<C-o>" },
			},
		},
		cmp = {
			text = {
				prerelease = "  pre-release ",
				yanked = "  yanked ",
			},
		},
	})
end

return M
