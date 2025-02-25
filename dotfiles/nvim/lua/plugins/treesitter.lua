return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  build = ':TSUpdate',
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  config = function()
    local configs = require 'nvim-treesitter.configs'

    configs.setup {
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'elixir', 'heex', 'javascript', 'html', 'regex' },
      sync_install = false,
      highlight = { enable = true },
      modules = {},
      ignore_install = {},
      auto_install = true,
    }
  end,
}
