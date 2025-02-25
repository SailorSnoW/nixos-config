return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- completion
      'saghen/blink.cmp',
    },
    keys = {
      {
        '<leader>ca',
        function()
          vim.lsp.buf.code_action()
        end,
        desc = 'Code Actions',
      },
    },
    opts = {
      servers = {
      },
    },
  },
}
