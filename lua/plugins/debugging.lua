return {
  {
    -- debug your code
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require('dap')
      local dapui = require("dapui")

      dapui.setup()

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
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
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
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
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
      dap.configurations.rust = dap.configurations.cpp
      dap.configurations.oil = dap.configurations.cpp

      vim.keymap.set('n', '<Space>dd', function() require('dap').continue() end, { desc = "Start/Resume debugging session" })
      vim.keymap.set('n', '<Space>de', function()
        dap.terminate()
        dap.close()
        dapui.close()
      end, { desc = "Stop debugging session" })
      vim.keymap.set('n', '<Space>dl', function() require('dap').step_into() end, { desc = "Step into" })
      vim.keymap.set('n', '<Space>dh', function() require('dap').step_out() end, { desc = "Step out" })
      vim.keymap.set('n', '<Space>dj', function() require('dap').step_over() end, { desc = "Step over" })
      vim.keymap.set('n', '<Space>db', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  }
}
