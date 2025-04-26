return {
  'folke/lazydev.nvim',
  ft = 'lua', -- only load on lua files
  cmd = 'LazyDev',
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      { path = 'snacks.nvim', words = { 'Snacks' } },
    },
  },
}
