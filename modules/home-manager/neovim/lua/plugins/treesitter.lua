return {
    "nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false, -- Load immediately for better syntax highlighting
    after = function()
        local config = require("nvim-treesitter.config")
        config.setup({
            ensure_installed = {},
            sync_install = false,
            highlight = { enable = true },
            modules = {},
            ignore_install = {},
            auto_install = false,
        })
    end,
}
