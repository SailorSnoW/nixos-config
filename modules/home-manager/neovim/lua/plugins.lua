-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--

local function getlockfilepath()
	if require("nixCatsUtils").isNixCats and type(nixCats.settings.unwrappedCfgPath) == "string" then
		return nixCats.settings.unwrappedCfgPath .. "/lazy-lock.json"
	else
		return vim.fn.stdpath("config") .. "/lazy-lock.json"
	end
end
local lazyOptions = {
	lockfile = getlockfilepath(),
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}

require("nixCatsUtils.lazyCat").setup(nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }), {
	require("plugins/rosepine"),
	require("plugins/mini-icons"),
	require("plugins/snacks"),
	require("plugins/noice"),
	require("plugins/which-key"),
	require("plugins/lualine"),
	require("plugins/blink-cmp"),
	require("plugins/lsp"),
	require("plugins/treesitter"),
	require("plugins/conform"),
	require("plugins/lint"),
	require("plugins/rustacean"),
	require("plugins/roslyn"),
	require("plugins/lazydev"),
	require("plugins/trouble"),
	require("plugins/mini-pairs"),
	require("plugins/grug-far"),
	require("plugins/gitsigns"),
	require("plugins/render-markdown"),
	require("plugins/todo-comments"),
})
