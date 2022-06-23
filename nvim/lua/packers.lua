local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packers.lua source <afile> | PackerCompile
  augroup end
]])
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
return packer.startup(function(use)
	-- Packer can manage itself as an optional plugin
	-------------------------------------------------------------------------------------------------------
	use({ "wbthomason/packer.nvim" })

	-- LSP
	-------------------------------------------------------------------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer", -- simple to use language server installer,
		"tamago324/nlsp-settings.nvim", -- language server settings defined in json for,
		"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	})

	-- Fuzzy Finder
	-------------------------------------------------------------------------------------------------------
	-- Telescope
	use({ "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim" })

	-- Search + replace
	-------------------------------------------------------------------------------------------------------
	use({ { "mg979/vim-visual-multi", branch = "master" }, { "brooth/far.vim" } })

	-- Autocomplete + snippets
	-------------------------------------------------------------------------------------------------------
	-- Cmp
	use({
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-calc" },
		{ "hrsh7th/cmp-vsnip" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		--
		{ "L3MON4D3/LuaSnip" }, -- snippet engine
		{ "rafamadriz/friendly-snippets" },
	})

	-- Syntax
	-------------------------------------------------------------------------------------------------------
	use({
		{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
		{ "blackCauldron7/surround.nvim" },
		{ "jdhao/better-escape.vim" }, -- Insert escape
	})

	-- Explorer
	-------------------------------------------------------------------------------------------------------
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

	-- Whichkey
	-------------------------------------------------------------------------------------------------------
	use({ "folke/which-key.nvim" })

	-- Comment
	-------------------------------------------------------------------------------------------------------
	use({ "terrortylor/nvim-comment" })

	-- Floaterm + Rnvimr
	-------------------------------------------------------------------------------------------------------
	use({ "voldikss/vim-floaterm", "kevinhwang91/rnvimr" })

	-- Color schemes + Icons
	-------------------------------------------------------------------------------------------------------
	use({
		"norcalli/nvim-colorizer.lua",
		"kyazdani42/nvim-web-devicons",
		-- "christianchiarulli/nvcode-color-schemes.vim",
    'olimorris/onedarkpro.nvim',
	})

	-- Status Line and Bufferline
	-------------------------------------------------------------------------------------------------------
	use({ "nvim-lualine/lualine.nvim", "akinsho/nvim-bufferline.lua", "SmiteshP/nvim-gps" })

	-- Git
	-------------------------------------------------------------------------------------------------------
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- Autopairs + Autotag
	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })

	-- Startup
	-------------------------------------------------------------------------------------------------------
	use({
		"glepnir/dashboard-nvim",
		"lewis6991/impatient.nvim",
	})

	-- Indent
	use({ "lukas-reineke/indent-blankline.nvim" })
	if PACKER_BOOTSTRAP then
		packer.sync()
	end
end)
