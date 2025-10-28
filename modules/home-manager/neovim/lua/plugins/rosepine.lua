return {
	"rose-pine",
	priority = 1000,
	after = function()
		require("rose-pine").setup({
			styles = {
				transparency = true,
			},
		})

		vim.cmd("colorscheme rose-pine-moon")
	end,
}
