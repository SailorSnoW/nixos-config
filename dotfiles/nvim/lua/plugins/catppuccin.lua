return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      require('catppuccin').setup {
        transparent_background = true,

        integrations = {
          blink_cmp = true,
          gitsigns = true,
          mason = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
          fzf = true,
          notify = true,
          noice = true,
          indent_blankline = { enabled = true },
          markdown = true,
          grug_far = true,
          native_lsp = {
            enabled = true,
          },
          mini = {
            enabled = true,
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
