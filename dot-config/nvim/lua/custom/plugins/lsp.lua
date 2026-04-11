---@type PluginSpec[]
return {
  {
    'gh:folke/lazydev.nvim',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'gh:saghen/blink.cmp',
    version = 'v1',
    opts = {
      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
    configure = function(opts)
      require('blink-cmp').setup(opts)
    end,
  },
  {
    'gh:mason-org/mason.nvim',
    opts = {},
    priority = 1, -- configure before mason-lspconfig
  },
  {
    'gh:mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = vim.tbl_keys(require('custom.ls-configs')),
    }
  },
  'gh:neovim/nvim-lspconfig',
}
