return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>cF',
        function()
          require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
        end,
        mode = { 'n', 'v' },
        desc = 'Format Injected Langs',
      },
    },
    config = function()
      local conform = require 'conform'

      conform.setup {
        default_format_opts = {
          timeout_ms = 2000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
          lsp_format = 'fallback', -- not recommended to change
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          async = false,
          lsp_format = 'fallback',
        },

        formatters_by_ft = {
          lua = { 'stylua' },
          sh = { 'shfmt' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
          typescript = { 'prettierd', 'prettier' },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          astro = { 'prettier' },
          markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
          nix = { 'alejandra' },
          cs = { 'csharpier' },
          svelte = { 'prettier' },
        },
      }
    end,
  },
}
