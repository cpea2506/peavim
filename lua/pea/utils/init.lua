local utils_table = function(name_table)
	local tbl = {}

	for _, name in pairs(name_table) do
		local mod = require("pea.utils.func").prequire("pea.utils." .. name)

		if mod then
			tbl[name] = mod
		end
	end

	return tbl
end

local utils_name = {
	"func",
	"autocmd",
	"key_mapping",
}

return utils_table(utils_name)
