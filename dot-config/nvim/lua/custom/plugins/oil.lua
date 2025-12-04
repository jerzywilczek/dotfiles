return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
  },
  config = function(opts)
    require('oil').setup(opts)

    vim.keymap.set('n', '<leader>f', '<CMD>Oil<CR>', { desc = 'Open [F]ile explorer' })
  end,
  dependencies = { 'mini' },
  lazy = false,
}
