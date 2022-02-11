local lspconfig = require("lspconfig")
lspconfig.ccls.setup({
	root_dir = function()
		return vim.fn.getcwd()
	end,
})
