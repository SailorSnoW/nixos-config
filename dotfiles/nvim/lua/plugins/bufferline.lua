return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons' },
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    config = function()
      require('bufferline').setup {
        options = {
          close_command = function(n)
            Snacks.bufdelete(n)
          end,
          right_mouse_command = function(n)
            Snacks.bufdelete(n)
          end,
          diagnostics = 'nvim_lsp',
          always_show_bufferline = false,
          offsets = {
            {
              filetype = 'snacks_layout_box',
            },
          },
        },
        -- Enable catppuccin colors
        -- highlights = require('catppuccin.groups.integrations.bufferline').get(),
        highlights = require 'rose-pine.plugins.bufferline',
      }
    end,
  },
}
