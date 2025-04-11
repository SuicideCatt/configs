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
	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
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

vim.cmd.colorscheme("catppuccin-macchiato")
local hl = {
	"Normal", --[["NormalFloat",]] "NormalNC",
	"SignColumn",
--	"NvimTreeNormal", "NvimTreeNormalNC",
	"EndOfBuffer", -- "MsgArea"
}
for _, name in ipairs(hl) do
	vim.api.nvim_set_hl(0, name, {bg = "none"})
end

local lsp = require("lspconfig")
local lspcfg = require("lspconfig.configs")
lsp.clangd.setup({
	cmd = {"clangd", "--header-insertion=never", "--clang-tidy"},
	filetypes = {"c", "cpp"},
	root_dir = function(filename)
		return lsp.util.root_pattern("build/compile_commands.json",
			"compile_flags.txt", "compile_commands.json")(filename)
				or vim.fn.getcwd()
	end,
	settings = {
		clangd = {
			fallbackFlags = {"-std=c++20"},
		}
	}
})

lsp.lua_ls.setup({})
lsp.cmake.setup({})
lsp.gdscript.setup({})

if not lspcfg.glsl_analyzer then
	lspcfg.glsl_analyzer = {
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

local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}),
	sources = cmp.config.sources({
		{name = "nvim_lsp"},
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

require('gitsigns').setup()

require('nvim-highlight-colors').setup({
	enable_hex = true,
	enable_short_hex = true,
	enable_rgb = true,
	enable_ansi = true,
	enable_named_colors = true,
	enable_tailwind = true,
})
