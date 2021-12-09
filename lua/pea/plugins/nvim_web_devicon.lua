local M = {}

local custom_icons = {
	lock = {
		icon = "",
		color = "#bbbbbb",
		name = "Lock",
	},
	log = {
		icon = "",
		color = "#ffffff",
		name = "Log",
	},
	json = {
		icon = "ﬥ",
		color = "#cbcb41",
		name = "Json",
	},
	ts = {
		icon = "ﯤ",
		color = "#3172bc",
		name = "Ts",
	},
	js = {
		icon = "",
		color = "#e7d54c",
		name = "Js",
	},
	Procfile = {
		icon = "",
		color = "#6e286c",
		name = "Procfile",
	},
	Dockerfile = {
		icon = "",
		color = "#00a4ff",
		name = "Dockerfile",
	},
	["Dockerfile.dev"] = {
		icon = "",
		color = "#00a4ff",
		name = "Dockerfile",
	},
	["docker-compose.yml"] = {
		icon = "",
		color = "#00a4ff",
		name = "Dockerfile",
	},
	["Dockerfile.prod"] = {
		icon = "",
		color = "#00a4ff",
		name = "Dockerfile",
	},
	[".dockerignore"] = {
		icon = "",
		color = "#00a4ff",
		name = "Dockerfile",
	},
	[".env"] = {
		icon = "",
		color = "#faf743",
		name = "Env",
	},
	[".env.local"] = {
		icon = "",
		color = "#faf743",
		name = "Env",
	},
	css = {
		icon = "",
		color = "#42a5f5",
		name = "Css",
	},
	xml = {
		icon = "",
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
		icon = "",
		color = "#43a047",
		name = "Vim",
	},
	html = {
		icon = "",
		color = "#e44d26",
		name = "Html",
	},
	yaml = {
		icon = "",
		color = "#ff5252",
		name = "Yaml",
	},
	yml = {
		icon = "",
		color = "#ff5252",
		name = "Yaml",
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
	md = {
		icon = "",
		color = "#ffffff",
		name = "Md",
	},
	py = {
		icon = "",
		color = "#3c78aa",
		name = "Python",
	},
	rs = {
		icon = "",
		color = "#EE7950",
		name = "Rust",
	},
}

M.setup = function()
	require("nvim-web-devicons").set_icon(custom_icons)
end

return M
