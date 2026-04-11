vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

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

-- diagnostic messages
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
      return diagnostic.message
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

for server_name, config in pairs(require('custom.ls-configs')) do
  -- overwrite the lspconfig's defaults with the contents of ls-configs
  vim.lsp.config(server_name, config)
end

-- enable manually, since I assume I always have nu installed, and the lsp is the same binary
vim.lsp.enable('nushell')
