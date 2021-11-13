local M = {}

local custom_icons = {
	Dockerfile = {
		icon = "🐳",
		color = "#00a4ff",
		name = "Dockerfile",
	},
	css = {
		icon = "",
		color = "#42a5f5",
		name = "Css",
	},
	xml = {
		icon = "",
		color = "#98C15C",
		name = "Xml",
	},
	[".gitignore"] = {
		icon = "",
		color = "#aaeaff",
		name = "GitIgnore",
	},
	[".gitmodules"] = {
		icon = "",
		color = "#aaeaff",
		name = "GitModules",
	},
	vim = {
		icon = "",
		color = "#43a047",
		name = "Vim",
	},
	html = {
		icon = "",
		color = "#e44d26",
		name = "Html",
	},
	yaml = {
		icon = "",
		color = "#ff5252",
		name = "Yaml",
	},
	yml = {
		icon = "",
		color = "#ff5252",
		name = "Yml",
	},
	lua = {
		icon = "",
		color = "#42a5f5",
		name = "Lua",
	},
	pyc = {
		icon = "",
		color = "#3c78aa",
		name = "Pyc",
	},
	pyd = {
		icon = "",
		color = "#3c78aa",
		name = "Pyd",
	},
	pyo = {
		icon = "",
		color = "#3c78aa",
		name = "Pyo",
	},
	py = {
		icon = "",
		color = "#3c78aa",
		name = "Py",
	},
	rs = {
		icon = "",
		color = "#EE7950",
		name = "Rs",
	},
}

M.setup = function()
	require("nvim-web-devicons").set_icon(custom_icons)
end

return M
