return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>ca",
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "Code Actions",
			},
			{
				"gd",
				function()
					vim.lsp.buf.definition()
				end,
				desc = "Go to Definition",
			},
			{
				"gr",
				function()
					vim.lsp.buf.references()
				end,
				desc = "Go to References",
			},
			{
				"K",
				function()
					vim.lsp.buf.hover()
				end,
				desc = "Hover Documentation",
			},
			{
				"<leader>rn",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename Symbol",
			},
			{
				"<leader>cf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "Format Document",
				mode = { "n", "v" },
			},
		},
		config = function() end,
	},
}
