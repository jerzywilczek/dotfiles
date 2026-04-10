---@module 'custom.pack'
---@type PluginSpec[]
return {
  'https://github.com/tpope/vim-sleuth',
  {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
    configure = function ()
      require('ibl').setup({})
    end
  },
}
