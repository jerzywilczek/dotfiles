vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- See `:help K` for why this keymap
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation', { 'n', 'i' })

    -- Lesser used LSP functionality
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Add a format keybind
    map('<leader>df', vim.lsp.buf.format, '[D]ocument [F]ormat')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      -- if client.name ~= "zls" then
      vim.lsp.inlay_hint.enable(true)
      -- end
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.diagnostic.config({
  severity_sort = true,
  -- float = { border = 'rounded', source = 'if_many' },
  float = false,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT },
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
  virtual_lines = {
    severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR },
    current_line = true,
  },
  jump = {
    float = false,
  },
})

---@type table<string, vim.lsp.Config>
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },

  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        completion = {
          callable = {
            snippets = 'add_parentheses',
          },
        },
      },
    },
  },

  zls = {
    settings = {
      enable_argument_placeholders = false,
      enable_build_on_save = true,
      build_on_save_args = { 'check' },
    },
  },
}

for server_name, config in pairs(servers) do
  vim.lsp.config(server_name, config)
end

vim.lsp.enable('nushell')

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
})

---@module 'custom.pack'
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
      ensure_installed = ensure_installed,
    }
  },
  'gh:neovim/nvim-lspconfig',
}
