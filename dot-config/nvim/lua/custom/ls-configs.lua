--- Setting an option in a table for a specific language server will overwrite it
--- (servers are configured with lspconfig's defaults)
---@type table<string, vim.lsp.Config>
return {
  lua_ls = {},

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

  stylua = {},
}
