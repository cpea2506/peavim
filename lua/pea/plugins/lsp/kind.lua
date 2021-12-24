local M = {}

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = " ",
	Color = " ",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = " ",
}

local kind_order = {
	"Text",
	"Method",
	"Function",
	"Constructor",
	"Field",
	"Variable",
	"Class",
	"Interface",
	"Module",
	"Property",
	"Unit",
	"Value",
	"Enum",
	"Keyword",
	"Snippet",
	"Color",
	"File",
	"Reference",
	"Folder",
	"EnumMember",
	"Constant",
	"Struct",
	"Event",
	"Operator",
	"TypeParameter",
}

M.symbolic = function(kind)
	return string.format("%s%s", kind_icons[kind] .. " ", kind)
end

function M.setup(opts)
	if opts == nil then
		opts = {}
	end

	local symbols = {}
	for i = 1, #kind_order do
		local kind = kind_order[i]
		symbols[i] = M.symbolic(kind)
	end

	for k, v in pairs(symbols) do
		vim.lsp.protocol.CompletionItemKind[k] = v
	end

	return function(entry, vim_item)
		if opts.before then
			vim_item = opts.before(entry, vim_item)
		end

		vim_item.kind = M.symbolic(vim_item.kind)

		if opts.menu ~= nil then
			vim_item.menu = opts.menu[entry.source.name]
		end

		if opts.maxwidth ~= nil then
			vim_item.abbr = string.sub(vim_item.abbr, 1, opts.maxwidth)
		end

		return vim_item
	end
end

return M
