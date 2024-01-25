local path = "/home/suicidecatt/.local/share/lvim/mason/bin/"

local lsp = require("lspconfig")

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {"clangd"})

local opts = {
	cmd = {path .. "clangd", "--header-insertion=never", "--clang-tidy"},
	root_dir = lsp.util.root_pattern("./build/compile_commands.json",
		"compile_flags.txt")
}

require("lvim.lsp.manager").setup("clangd", opts)
