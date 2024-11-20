-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  config = function()
    local which = require('which-key')

    which.setup({})

    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    which.add({
      { '<leader>', group = 'VISUAL <leader>', mode = 'v' },
      { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
    })

    which.add({
      { '<leader>c', group = '[C]ode'},
      { '<leader>d', group = '[D]ocument'},
      { '<leader>g', group = '[G]it'},
      { '<leader>h', group = 'Git [H]unk'},
      { '<leader>r', group = '[R]ename'},
      { '<leader>s', group = '[S]earch'},
      { '<leader>t', group = '[T]oggle'},
      { '<leader>w', group = '[W]orkspace'},
    })
  end
}
