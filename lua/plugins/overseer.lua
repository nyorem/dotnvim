return {
  {
    "stevearc/overseer.nvim",
    enabled = true,
    config = function()
      local overseer = require("overseer")
      local build_task

      overseer.setup()

      vim.keymap.set("n", "<Leader>cg", function()
        overseer.run_task({ name = "CMake configure",
          params = {
            build_type = "debug",
            extra_cmake_args = "",
          }
        }) end,
        { desc = "Configure with default arguments" })

      vim.keymap.set("n", "<Leader>cG", function()
        overseer.run_task({ name = "CMake configure" }) end,
        { desc = "Configure with extra arguments" })

      vim.keymap.set("n", "<Leader>cc", function()
        overseer.run_task({ name = "Build target",
          params = {
            target = "all",
            jobs = 4,
          }
        },
        function(task)
          build_task = task
        end)
      end, { desc = "Build with default arguments" })

      vim.keymap.set("n", "<Leader>ck", function()
        if build_task then
          build_task:stop()
        end
      end, { desc = "Stop current build task" })

      vim.keymap.set("n", "<Leader>cC", function()
        overseer.run_task({ name = "Build target" },
          function(task)
            build_task = task
          end
        )
      end, { desc = "Build with extra arguments" })
    end,
  },
}
