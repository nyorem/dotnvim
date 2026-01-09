return {
  {
    -- debug your code
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap-python",
        "igorlfs/nvim-dap-view",
    },
    config = function()
      local dap = require('dap')

      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.env.HOME .. '/dev/bin/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
          end,
          args = function()
            return { vim.fn.input('Arguments: ', '--gtest_filter=*') }
          end,
          cwd = '${workspaceFolder}',
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description =  'enable pretty printing',
              ignoreFailures = false
            },
          },
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'cppdbg',
          request = 'launch',
          MIMode = 'gdb',
          miDebuggerServerAddress = 'localhost:1234',
          miDebuggerPath = '/usr/bin/gdb',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
          end,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description =  'enable pretty printing',
              ignoreFailures = false
            },
          },
        },
      }

      require("dap-python").setup("python3")

      dap.configurations.c = dap.configurations.cpp

      vim.keymap.set('n', '<Leader>dd', "<CMD>DapViewToggle<CR>", { desc = "Open Dap View" })
      vim.keymap.set('n', '<Leader>dw', "<CMD>DapViewWatch<CR>", { desc = "Watch current variable" })
      vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end, { desc = "Start/Resume debugging session" })
      vim.keymap.set('n', '<Leader>de', function()
        dap.terminate()
        dap.close()
      end, { desc = "Stop debugging session" })
      vim.keymap.set('n', '<Leader>dl', function() require('dap').step_into() end, { desc = "Step into" })
      vim.keymap.set('n', '<Leader>dh', function() require('dap').step_out() end, { desc = "Step out" })
      vim.keymap.set('n', '<Leader>dj', function() require('dap').step_over() end, { desc = "Step over" })
      vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })
    end,
  }
}
