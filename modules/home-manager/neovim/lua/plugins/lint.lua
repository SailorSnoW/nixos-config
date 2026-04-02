return {
	"nvim-lint",
	event = { "BufWritePost", "BufReadPost", "InsertLeave" },
	after = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			nix = { "statix" },
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
