vim.pack.add({
	-- Dependencias
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
	-- Plugins
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/jake-stewart/multicursor.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/alex-popov-tech/store.nvim", depends = { "markview.nvim" } },
	{
		src = "https://github.com/Saghen/blink.cmp",
		depends = { "friendly-snippets", "LuaSnip", "lspkind.nvim" },
		checkout = "v0.*",
	},
	{ src = "https://github.com/nvim-telescope/telescope.nvim", depends = { "plenary.nvim", "nvim-web-devicons" } },
	{ src = "https://github.com/stevearc/oil.nvim", depends = { "mini.icons" } },
	{ src = "https://github.com/folke/noice.nvim", depends = { "nui.nvim", "nvim-notify" } },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		-- LSP
		"typescript-language-server",
		"html-lsp",
		"lua_ls",
		"css-lsp",
		"emmet-ls",
		"cucumber-language-server",

		-- Formatters
		"prettier",
		"stylua",
		"black",

		-- Linters
		"eslint_d",
	},
})
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()
require("store").setup()

-- Plugins Con Configuracion
require("plugins.oil")
require("plugins.noice")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.statusline")
require("plugins.multicursor")
require("plugins.multicursor")
require("plugins.formatter")
require("plugins.blink")
require("plugins.copilot")
require("plugins.flash")
require("plugins.lsp")

-- Colorscheme Catppuccin
vim.cmd.colorscheme("catppuccin-mocha")
