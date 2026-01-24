return {
  'folke/snacks.nvim',

  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    profiler = {},
    picker = {
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          }
        }
      }
    },
  },
  keys = {
    -- profiler
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
    },

    -- picker
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
    -- { '<leader>ss', function() builtin end, desc = '[S]earch [S]elect Telescope' },
    -- { '<leader>sw', function() grep_string end, desc = '[S]earch current [W]ord' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
    -- { '<leader>sd', function() diagnostics end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
    { '<leader>?', function() Snacks.picker.recent() end, desc = 'Find recently opened files' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = 'Serch current buffer by grep' },

    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = '[G]oto [R]eferences' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = '[G]oto [I]mplementation' },
    { '<leader>D', function() Snacks.picker.lsp_type_definitions() end, desc = 'Type [D]efinition' },
    { '<leader>ds', function() Snacks.picker.lsp_symbols() end, desc = '[D]ocument [S]ymbols' },
    { '<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, desc = '[W]orkspace [S]ymbols' },
  },
}
