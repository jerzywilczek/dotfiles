---@module 'custom.pack'
---@type PluginSpec
return {
  'gh:folke/trouble.nvim',
  configure = function()
    require('trouble').setup({})

    vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle focus=true<cr>',
      { desc = 'toggle [T]rouble (diagnostics)' })

    vim.keymap.set('n', '<leader>ts', '<cmd>Trouble symbols toggle focus=true<cr>',
      { desc = 'toggle [T]rouble ([S]ymbols)' })
  end,
}
