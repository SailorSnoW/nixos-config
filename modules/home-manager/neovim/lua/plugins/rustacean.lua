return {
    {
        "rustaceanvim",
        lazy = false, -- This plugin is already lazy
        opts = {
            server = {
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        files = {
                            excludeDirs = {
                                ".direnv",
                                ".git",
                                ".github",
                                ".gitlab",
                                "bin",
                                "node_modules",
                                "target",
                                "venv",
                                ".venv",
                            },
                        },

                        rust = {
                            analyzerTargetDir = "target/nvim-rust-analyzer",
                        },
                        server = {
                            extraEnv = {
                                ["CHALK_OVERFLOW_DEPTH"] = "100000000",
                                ["CHALK_SOLVER_MAX_SIZE"] = "100000000",
                            },
                        },
                        cargo = {
                            features = "all",
                            extraEnv = {
                                ["SKIP_WASM_BUILD"] = "1",
                            },
                        },
                        procMacro = {
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                                ["async-std"] = { "async_std" },
                            },
                        },
                    },
                },
            },
        },
        after = function(_, opts)
            vim.g.rustaceanvim = opts
        end,
    },
}
