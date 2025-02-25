return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {
    modes = {
      lsp = {
        win = { position = 'right' },
      },
    },
  },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
    { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
  },
}
