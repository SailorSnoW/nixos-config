return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- LSP package manager
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- completion
      'saghen/blink.cmp',
    },
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason Installer' },
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
      local mason = require 'mason'
      local mason_lspconfig = require 'mason-lspconfig'
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      mason.setup()
      mason_lspconfig.setup {
        ensure_installed = {
          'lua_ls',
          'astro',
          'clangd',
          'cmake',
          'cssls',
          'dockerls',
          'docker_compose_language_service',
          'elixirls',
          'graphql',
          'html',
          'biome',
          'ts_ls',
          'jsonls',
          'marksman',
          'nil_ls',
          'solang',
          'svelte',
          'taplo',
          'vtsls',
          'yamlls',
        },
      }

      mason_lspconfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup { { capabilities = capabilities } }
        end,
      }
    end,
  },
}
