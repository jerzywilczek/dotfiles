---@module 'custom.pack'
---@type PluginSpec
return {
  'gh:stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
  },
  configure = function(opts)
    require('oil').setup(opts)

    vim.keymap.set('n', '<leader>f', '<CMD>Oil<CR>', { desc = 'Open [F]ile explorer' })
  end,
}
