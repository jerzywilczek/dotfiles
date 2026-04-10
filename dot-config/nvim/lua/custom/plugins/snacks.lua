---@module 'custom.pack'
---@type PluginSpec
return {
  'gh:folke/snacks.nvim',

  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    profiler = {},
    picker = {
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<C-c>'] = { 'cancel' },
          },
        },
      },
    },
  },

  configure = function(opts)
    require('snacks').setup(opts)

    -- profiler
    vim.keymap.set('n', '<leader>ls', function()
      Snacks.profiler.scratch()
    end, { desc = 'Profi[L]er [S]cratch Bufer' })
    vim.keymap.set('n', '<leader>ll', function()
      Snacks.profiler.toggle()
    end, { desc = 'Toggle Profi[L]er' })
    vim.keymap.set('n', '<leader>lh', function()
      Snacks.profiler.highlight()
    end, { desc = 'Toggle Profi[L]er [H]ighlights' })

    -- picker
    vim.keymap.set('n', '<leader>sh', function()
      Snacks.picker.help()
    end, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', function()
      Snacks.picker.keymaps()
    end, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      Snacks.picker.files()
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', function()
      Snacks.picker.grep()
    end, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sr', function()
      Snacks.picker.resume()
    end, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>?', function()
      Snacks.picker.recent()
    end, { desc = 'Find recently opened files' })
    vim.keymap.set('n', '<leader>/', function()
      Snacks.picker.lines()
    end, { desc = 'Serch current buffer by grep' })

    vim.keymap.set('n', 'gd', function()
      Snacks.picker.lsp_definitions()
    end, { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gr', function()
      Snacks.picker.lsp_references()
    end, { nowait = true, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', function()
      Snacks.picker.lsp_implementations()
    end, { desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>D', function()
      Snacks.picker.lsp_type_definitions()
    end, { desc = 'Type [D]efinition' })
    vim.keymap.set('n', '<leader>ds', function()
      Snacks.picker.lsp_symbols()
    end, { desc = '[D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>ws', function()
      Snacks.picker.lsp_workspace_symbols()
    end, { desc = '[W]orkspace [S]ymbols' })
  end,
}
