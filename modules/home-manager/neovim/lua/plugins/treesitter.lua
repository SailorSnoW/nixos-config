return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = require("nixCatsUtils").lazyAdd(":TSUpdate"),
	lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = require("nixCatsUtils").lazyAdd({
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"html",
				"regex",
			}),
			sync_install = false,
			highlight = { enable = true },
			modules = {},
			ignore_install = {},
			auto_install = require("nixCatsUtils").lazyAdd(true, false),
		})
	end,
}
