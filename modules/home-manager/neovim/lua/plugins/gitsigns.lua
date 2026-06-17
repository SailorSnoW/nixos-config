return {
	"lewis6991/gitsigns.nvim",
	event = { "BufNewFile" },
	after = function()
		require("gitsigns").setup()
	end,
}
