return {
	{
		"mini.icons",
		after = function()
			local MiniIcons = require("mini.icons")
			require("mini.icons").setup(MiniIcons.mock_nvim_web_devicons())
		end,
	},
}
