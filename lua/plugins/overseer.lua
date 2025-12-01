return {
  {
    "stevearc/overseer.nvim",
    enabled = true,
    config = function()
      local overseer = require("overseer")

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
        })
      end, { desc = "Build with default arguments" })

      vim.keymap.set("n", "<Leader>cC", function()
        overseer.run_task({ name = "Build target" })
      end, { desc = "Build with extra arguments" })
    end,
  },
}
