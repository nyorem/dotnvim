return {
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    config = function()
      require("tree-sitter-manager").setup({
        ensure_installed = { "bash", "c", "cmake", "cpp", "comment", "json", "lua", "markdown", "markdown_inline", "python", "query", "regex", "vim", "vimdoc", "yaml" },
      })
    end
  },
  {
    -- syntax-aware text objects and motions (provides the `textobjects`
    -- queries used by mini.ai for aF/iF/aC/iC selections too)
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = { set_jumps = true },
      })

      local move = require("nvim-treesitter-textobjects.move")

      -- Jump to start/end of next/previous function.
      vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function start" })
      vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Previous function end" })
    end,
  },
}
