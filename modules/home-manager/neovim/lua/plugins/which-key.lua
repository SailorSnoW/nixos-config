return {
    "which-key.nvim",

    after = function()
        local wk = require("which-key")

        wk.setup({
            preset = "helix",
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>f", group = "file/find" },
                    { "<leader>s", group = "search" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                },
            },
        })

        vim.keymap.set("n", "<leader>?", function()
            wk.show({ global = false })
        end, { desc = "Buffer Keymaps (which-key)" })
    end,
}
