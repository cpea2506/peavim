pea = require("pea.config.setting")

-- default theme
vim.cmd("colorscheme one_monokai")

require("pea")
require("pea.utils.func").call_setup({ "config.default", "utils", "plugins" }, "pea")

-- user theme
vim.cmd("colorscheme " .. pea.theme)
