return {
  {
    -- end certain structures automatically
    "tpope/vim-endwise",
  },
  {
    -- UNIX helpers
    "tpope/vim-eunuch",
  },
  {
    -- heuristically set buffer options
    "tpope/vim-sleuth",
  },
  {
    -- handy brackets mappings
    -- '=p' => smarter paste command that preserves indentation
    "tpope/vim-unimpaired",
    config = function()
      -- '(' and ')' are more accessible on an AZERTY layout
      vim.keymap.set({"n", "o", "x"}, "(", "[", { remap = true })
      vim.keymap.set({"n", "o", "x"}, ")", "]", { remap = true })
    end,
  },
  {
    -- disable search highlighting when you are done with searching
    'romainl/vim-cool',
  },
  {
    -- sudo write
    "lambdalisue/vim-suda",
    config = function()
      vim.keymap.set("c", "w!!", ":SudaWrite")
    end
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    opts = {},
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
      set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
      set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor and go above" })
      set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end, { desc = "Skip cursor and go below" })

      -- Add or skip adding a new cursor by matching word/selection
      set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end, { desc = "Add cursor to next match" })
      set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end, { desc = "Skip match and go to next" })
      set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end, { desc = "Add cursor to previous match" })
      set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end, { desc = "Skip match and go to previous" })
      set({"n", "x"}, "<leader>A", mc.matchAllAddCursors, { desc = "Add cursor to all matches" })

      -- Add a cursor and jump to the next/previous search result.
      set("n", "<leader>/n", function() mc.searchAddCursor(1) end, { desc = "Add cursor to next search result" })
      set("n", "<leader>/N", function() mc.searchAddCursor(-1) end, { desc = "Add cursor to previous search result" })

      -- Jump to the next/previous search result without adding a cursor.
      set("n", "<leader>/s", function() mc.searchSkipCursor(1) end, { desc = "Skip to next search result" })
      set("n", "<leader>/S", function() mc.searchSkipCursor(-1) end, { desc = "Skip to previous search result" })

      -- Add a cursor to every search result in the buffer.
      set("n", "<leader>/A", mc.searchAllAddCursors, { desc = "Add cursor to all search results" })

      -- Disable and enable cursors.
      set({"n", "x"}, "<c-q>", mc.toggleCursor, { desc = "Toggle cursors" })

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({"n", "x"}, "<left>", mc.prevCursor)
        layerSet({"n", "x"}, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn"})
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end,
  },
}
