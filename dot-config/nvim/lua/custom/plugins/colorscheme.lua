---@module 'custom.pack'
---@type PluginSpecTable
return {
  'gh:catppuccin/nvim',
  priority = 1000,
  configure = function ()
    require('catppuccin').setup({
      flavor = 'macchiato',
      auto_integrations = true,
    })
    vim.cmd.colorscheme('catppuccin-macchiato')
  end
}
