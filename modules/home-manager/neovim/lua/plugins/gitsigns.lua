return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("gitsigns").setup()
	end,
}
