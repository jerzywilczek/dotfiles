---@type PluginSpec[]
return {
  'cb:andyg/leap.nvim',
  configure = function(opts)
    local leap = require('leap')
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end

    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>x', '<Plug>(leap)', { desc = 'leap' })
    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>X', '<Plug>(leap-from-window)', { desc = 'leap from window' })
  end,
}
