vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.cursorline = true

vim.opt.number = true

vim.opt.swapfile = false;

vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"

vim.opt.clipboard = "unnamedplus"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	checker = { enabled = false },
	{"catppuccin/nvim", name = "catppuccin", priority = 1000},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {'nvim-tree/nvim-web-devicons'}
	},
	{"nvim-tree/nvim-tree.lua"},
	{"tree-sitter/tree-sitter"},
	{"nvim-treesitter/nvim-treesitter"},
--	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-nvim-lua"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
--	{"hrsh7th/cmp-cmdline"},
	{"hrsh7th/nvim-cmp"},
	{"akinsho/bufferline.nvim"},
	{"lewis6991/gitsigns.nvim"},
	{'brenoprata10/nvim-highlight-colors'},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{"OXY2DEV/markview.nvim"},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"
		}
	}
})

require("nvim-tree").setup({
	git = {
		enable = true,
		ignore = false,
	}
})
require("ibl").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c", "cpp", "lua", "cmake", "make", "bash",
		"markdown", "markdown_inline", "glsl"
	},
	sync_install = true,
	auto_install = false,

	highlight = {
		enable = true
	}
})

vim.cmd.colorscheme("catppuccin-mocha")
local hl = {
	"Normal", --[["NormalFloat",]] "NormalNC",
	"SignColumn",
--	"NvimTreeNormal", "NvimTreeNormalNC",
	"EndOfBuffer", -- "MsgArea"
}
for _, name in ipairs(hl) do
	vim.api.nvim_set_hl(0, name, {bg = "none"})
end

vim.lsp.enable("clangd")
vim.lsp.config("clangd", {
	cmd = {"clangd", "--header-insertion=never", "--completion-style=detailed", "--clang-tidy"},
	filetypes = {"c", "cpp"},
	root_markers = {
		"build/compile_commands.json",
		"compile_flags.txt",
		"compile_commands.json"
	}
})

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	cmd = {"lua-language-server"},
	filetypes = {"lua"},
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.luacheckrc',
		'.stylua.toml',
		'stylua.toml',
		'selene.toml',
		'selene.yml',
		'.git',
	},
	single_file_support = true
})

vim.lsp.enable("cmake")
vim.lsp.config("cmake", {
	cmd = {"cmake-language-server"},
	filetypes = {"cmake"},
	root_markers = {
		'CMakePresets.json',
		'CTestConfig.cmake',
		'.git',
		'build',
		'cmake',
	},
	single_file_support = true,
	init_options = {
		buildDirectory = 'build',
	},
})

vim.lsp.enable("gdscript")
vim.lsp.config("gdscript", {
	cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(os.getenv 'GDScript_Port' or '6005')),
	filetypes = {'gd', 'gdscript', 'gdscript3'},
	root_markers = {"project.godot", ".git"},
})

vim.lsp.enable("glsl_analyzer")
vim.lsp.config("glsl_analyzer", {
	cmd = {"glsl_analyzer", "--stdio"},
	root_markers = {'.git'},
	filetypes = {"glsl"},
	autostart = true,
	single_file_support = true
})

local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}),
	sources = cmp.config.sources({
		{name = "nvim_lsp"},
		{name = "nvim_lua"},
		{name = "buffer"},
		{name = "path"}
	})
})

require("lualine").setup({
	options = {
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
	},
	sections = {
		lualine_a = {"mode"},
		lualine_b = {"branch", "diff"},
		lualine_c = {"filename"},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {"branch", "diff"},
		lualine_c = {"filename"},
	}
})

local bufferline = require("bufferline")
bufferline.setup {
	options = {
		style_preset = bufferline.style_preset.no_italic,
		offsets = {
			{
				filetype = "NvimTree",
				text = "Files",
				text_align = "center",
				separator = true
			}
		},
		diagnostics = "nvim_lsp"
	}
}
require("bufferline.groups").builtin.pinned:with({icon = "󰐃 "})

vim.keymap.set("n", "<C-p>", "<Cmd>BufferLineTogglePin<CR>")
vim.keymap.set("n", "<C-e>", "<Cmd>NvimTreeFocus<CR>")
vim.keymap.set("n", "<C-c>", "<Cmd>%s/\\s\\+$//<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<C-S-k>", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "<C-d>", "<Cmd>lua vim.diagnostic.open_float()<CR>")

require('gitsigns').setup()

require('nvim-highlight-colors').setup({
	enable_hex = true,
	enable_short_hex = true,
	enable_rgb = true,
	enable_ansi = true,
	enable_named_colors = true,
	enable_tailwind = true,
})

local dap = require('dap')
dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-dap',
	name = 'lldb'
}

dap.configurations.cpp = {{
	name = 'Launch',
	type = 'lldb',
	request = 'launch',
	program = function()
		return vim.fn.input('Path to executable: ',
							vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = '${workspaceFolder}',
	stopOnEntry = false,
	args = {},
}}

require('dapui').setup()

vim.keymap.set("n", "gdp", "<Cmd>DapToggleBreakpoint<CR>")
vim.keymap.set("n", "gdb",
			   "<Cmd>tab new<CR><Cmd>lua require('dapui').open()<CR>")
vim.keymap.set("n", "gv", "<Cmd>lua require('dapui').eval()<CR>")
