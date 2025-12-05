return {
  'folke/snacks.nvim',
  opts = {
    profiler = {}
  },
  keys = {
    {
      '<leader>ls',
      function()
        Snacks.profiler.scratch()
      end,
      desc = 'Profi[L]er [S]cratch Bufer',
    },
    {
      '<leader>ll',
      function()
        Snacks.profiler.toggle()
      end,
      desc = 'Toggle Profi[L]er',
    },
    {
      '<leader>lh',
      function()
        Snacks.profiler.highlight()
      end,
      desc = 'Toggle Profi[L]er [H]ighlights',
    }
  },
}
