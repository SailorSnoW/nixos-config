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
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      lspconfig['lua_ls'].setup { { capabilities = capabilities } }
      lspconfig['dockerls'].setup { { capabilities = capabilities } }
      lspconfig['docker_compose_language_service'].setup { { capabilities = capabilities } }
      lspconfig['elixirls'].setup { { capabilities = capabilities } }
      lspconfig['jsonls'].setup { { capabilities = capabilities } }
      lspconfig['marksman'].setup { { capabilities = capabilities } }
      lspconfig['nixd'].setup { { capabilities = capabilities } }
      lspconfig['svelte'].setup { { capabilities = capabilities } }
      lspconfig['tailwindcss'].setup { { capabilities = capabilities } }
      lspconfig['vtsls'].setup { { capabilities = capabilities } }
      lspconfig['yamlls'].setup { { capabilities = capabilities } }
    end,
  },
}
