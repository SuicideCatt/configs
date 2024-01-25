-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Hack
local function add_plugin(plugin)
	table.insert(lvim.plugins, {plugin})
end

-- Normal tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

-- Alpha bg
lvim.transparent_window = true

-- Limiter
add_plugin("lukas-reineke/virt-column.nvim")
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
require("virt-column").setup()

-- Theme
add_plugin("catppuccin/nvim")
lvim.colorscheme = "catppuccin-macchiato"

-- Keybinds
lvim.keys.normal_mode["<C-e>"] = ":NvimTreeFocus<CR>"
lvim.keys.normal_mode["<C-c>"] = ":%s/\\s\\+$//<CR>"

-- Space menu
local function add_cmake_to_menu()
	local commad = "<cmd>!cmake"
	local flags = "-DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"

	lvim.builtin.which_key.mappings["m"] = {
		name = "CMake",
		b = {commad .. " --build ./build -j$(nproc)<CR>", "Build"},
		u = {commad .. " -B ./build " .. flags .. " <CR>", "Update/Create"},
	}
end

add_cmake_to_menu()

-- Statuc line
local line = lvim.builtin.lualine.sections
-- local lunar = require("lvim.core.lualine.components")
line.lualine_a = {"mode"}
line.lualine_b = {"branch", "diff"}
line.lualine_c = {"filename"}

-- lsp
local lsp = require("lspconfig")
local cfg = require("lspconfig.configs")

if not cfg.glsl_analyzer then
	cfg.glsl_analyzer = {
		default_config = {
			cmd = {"glsl_analyzer", "--stdio"},
			root_dir = lsp.util.root_pattern('.git'),
			filetypes = {"glsl"},
			autostart = true,
			single_file_support = true
 		}
	}
end

lsp.glsl_analyzer.setup{}
