return {
	"nvim-lint",
	-- Event to trigger linters
	event = { "BufWritePost", "BufReadPost", "InsertLeave" },
	after = function()
		local lint = require("lint")

		lint.linters_by_ft = {}
	end,
}
