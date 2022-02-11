local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = { "xml", "typescriptreact", "javascriptreact", "jinja", "html" },
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {}, -- table of hex strings
		termcolors = {}, -- table of colour name strings
	},
	-- playground = {
	-- enable = true,
	-- disable = {},
	-- updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
	-- persist_queries = false, -- Whether the query persists across vim sessions
	-- },
	-- refactor = { highlight_definitions = { enable = true }, highlight_current_scope = { enable = true } },
})