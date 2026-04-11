---@type PluginSpec[]
return {
  {
    'gh:mfussenegger/nvim-dap',
    configure = function()
      for _, group in pairs({
        'DapBreakpoint',
        'DapBreakpointCondition',
        'DapBreakpointRejected',
        'DapLogPoint',
      }) do
        vim.fn.sign_define(group, { text = '●', texthl = group })
      end

      local dap = require('dap')

      dap.adapters.codelldb = {
        type = 'executable',
        command = 'codelldb',
      }

      dap.configurations.rust = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = function()
            local args = vim.fn.input('Args (Enter for no args): ')
            return vim.split(args, ' ')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          initCommands = function()
            -- necessary for proper rust formatting
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, 1, script_import)
            return commands
          end,
        },
      }

      vim.keymap.set('n', '[f', dap.up, { desc = 'DAP up' })
      vim.keymap.set('n', ']f', dap.down, { desc = 'DAP down' })

      vim.keymap.set({ 'n', 'v' }, '<F1>', require('dap.ui.widgets').hover, { desc = 'DAP Hover' })
      vim.keymap.set('n', '<F4>', function()
        dap.terminate({ hierarchy = true })
      end, { desc = 'DAP Terminate' })
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP Continue' })

      vim.keymap.set('n', '<F8>', function()
        vim.ui.input({ prompt = 'Log point message: ' }, function(input)
          dap.set_breakpoint(nil, nil, input)
        end)
      end, { desc = 'Toggle Logpoint' })
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })

      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Step Out' })

      vim.keymap.set('n', '<S-F5>', dap.run_last, { desc = 'Run Last' })
      vim.keymap.set('n', '<S-F6>', dap.run_to_cursor, { desc = 'Run to Cursor' })

      vim.keymap.set('n', '<S-F9>', function()
        vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(input)
          dap.set_breakpoint(input)
        end)
      end, { desc = 'Conditional Breakpoint' })
    end,
  },
  {
    'gh:igorlfs/nvim-dap-view',

    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'console' },
      },
      auto_toggle = true,
    },
    configure = function(opts)
      require('dap-view').setup(opts)
      vim.keymap.set('n', '<leader>tD', function()
        require('dap-view').toggle()
      end, { desc = '[t]oggle [D]AP view' })
    end,
  },
}
