return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	lazy = false, -- Load immediately for better syntax highlighting
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {},
			sync_install = false,
			highlight = { enable = true },
			modules = {},
			ignore_install = {},
			auto_install = false,
		})
	end,
}
