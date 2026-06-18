return {
	"render-markdown.nvim",
	after = function()
		require("render-markdown").setup({
			latex = { enabled = false },
		})
	end,
}
