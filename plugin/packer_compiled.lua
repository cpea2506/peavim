-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/CPea2506/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/CPea2506/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/CPea2506/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/CPea2506/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/CPea2506/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/cmp-calc"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/cmp-treesitter"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["crates.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/crates.nvim"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29plugins.custom.dashboard\frequire\0" },
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["numb.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["numbers.vim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/numbers.vim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["one-monokai-vim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/one-monokai-vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["presence.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/presence.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/toggleterm.nvim"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/Users/CPea2506/.local/share/nvim/site/pack/packer/start/vim-move"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29plugins.custom.dashboard\frequire\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
if should_profile then save_profiles(1) end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
