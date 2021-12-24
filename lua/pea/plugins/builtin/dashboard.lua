local M = {}

local align_center = function(lines, alignment)
	local output = {}
	local max_len = 0

	for _, line in ipairs(lines) do
		local line_len = #line
		if line_len > max_len then
			max_len = line_len
		end
	end

	for _, line in ipairs(lines) do
		local padding = string.rep(" ", (math.max(0, max_len) - line:len()) * alignment)
		table.insert(output, padding .. line)
	end

	return output
end

M.setup = function()
	local config_path = "~/.config/nvim/lua/pea/config/init.lua"
	local packer_path = "~/.local/share/nvim/site/pack/packer/start"
	local num_plugins_loaded = #vim.fn.globpath(packer_path, "*", 0, 1)
	local name = "PeaVim"
	local footer = {
		name .. " loaded " .. num_plugins_loaded .. " plugins ",
		"",
		"Let me show you what is the true text editor!",
	}

	local config = {
		dashboard_custom_header = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡿⣟⣶⣿⣧⣿⣿⣦⢿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣏⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⠘⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠂⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⡙⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣶⡿⣿⣿⣶⣦⣭⠻⢿⣿⣿⣿⣷⡙⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⢿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⠻⣿⣿⣿⣶⠙⣿⣿⣸⣿⣿⣿⣿⡟⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣄⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡙⣿⣿⣿⣷⣍⠻⣿⣿⣿⣿⣿⣾⣿⣿⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣶⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣭⣭⣭⣭⣙⣛⠿⣿⣿⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣍⢿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣛⢿⣿⣿⣿⣿⣿⣿⣦⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡹⣿⣿⣿⣿⣿⡄⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠉⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⠁ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⠿⣿⠿⢷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⡇⣿⡿⣿⠿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⢠⣿⣿⠋⠀⣴⣿⠿⠉⠀⠀⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡿⣿⣛⢿⣿⣸⣶⡿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⢀⣿⣿⠀⠀⣰⡿⡟⠀⠀⠀⠀⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⡿     ⣿⣿⣿ ⣉⣭⠿⠉⣼⡿⠟⠀⠛⢿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⢸⣿⠃⠀⢀⣿⣿⠀⠀⠀⠀⣠⣿⣿⠀⣤⣾⣿⣿⣦⡀⠀⣠⣶⣿⣿⣶⣾⣷⣿⣿⠻⠿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀⠀⣼⡿⡟⠀⣾⣶⠀⠀⣼⣷⣾⣿⢿⣦⣠⣾⣿⣿⣶⣀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠙ ⠀⣾⣿⣥⣀⣀⣤⣾⡿⠟⢠⣿⡿⠋⣀⣾⡿⠃⣾⡿⠟⠀⠀⣿⡿⠋⠈⠿⣶⣤⠀⠀⠀⢸⣿⡟⠀⠀⠀⠀⣰⡿⡿⠀⣾⡿⠋⠀⢰⣿⣿⠋⠀⢸⣿⣿⠛⠀⢠⣿⣿⠀⠀⠀",
			"⠀⠀⣀⣤⣀⠀⠀⠀⣸⣿⡟⠀⠉⠙⠉⠁⠀⢀⣿⣿⣿⣿⠿⠛⠀⣼⣿⠋⠀⠀⣼⣿⡟⠀⢀⣀⠀ ⠀⠀⠀⣿⣿⠀⠀⠀⠀⣰⣿⡿⠀⣼⡿⡿⠀⢠⣿⣿⠁⠀⢀⣿⣿⠁⠀⠀⣿⣿⠀⠀⣠⠀",
			"⣰⣿⡿⠉⠉⠀⠀⢠⣿⣿⠀⠀⠀⠀⠀⠀⠀⣾⡿⠉⠀⠀⠀⠀⣼⣿⣿⠀⠀⣼⣿⣿⠀⢠⣿⣿⠁⠀⠀⠀⢸⡿⠏⠀⠀⠀⣰⣿⡿⠀⢀⣿⣿⢀⢠⣿⡿⠁⠀⠀⣾⡿⠁⠀⠀⣾⡿⠋⠀⣼⡿⠟",
			"⣿⣿⠀⠀⠀⠀⣰⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣆⣀⣠⣴⣿⡿⣿⣿⣤⣿⣿⣿⣇⣶⣿⡿⠁⠀⠀⠀⠀⢸⣿⠀⠀⢀⣾⡿⠛⠀⠀⠸⡿⣇⣴⣿⣿⠃⠀⠀⣼⡿⠟⠀⠀⠀⣿⣿⣠⣾⣿⠋⠀",
			"⠀⠻⢷⣶⣾⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠉⠉⠉⠉  ⠀⠈⠉⠉⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⠿⠛⠀⠀⠀⠀⠀ ⠉⠉⠉⠉⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀",
		},
		dashboard_custom_section = {
			a = {
				description = { "  Find File          " },
				command = "Telescope find_files",
			},
			b = {
				description = { "  Recently Used Files" },
				command = "Telescope oldfiles",
			},
			c = {
				description = { "  Recent Projects    " },
				command = "Telescope projects",
			},
			d = {
				description = { "  Configuration      " },
				command = ":e " .. config_path,
			},
		},
		dashboard_custom_footer = align_center(footer, 0.5),
	}
	require("pea.utils.func").set_plugins_options(config)
end

return M
