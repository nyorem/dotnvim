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
    "tpope/vim-unimpaired",
    config = function()
      -- '(' and ')' are more accessible on an AZERTY layout
      vim.keymap.set({"n", "o", "x"}, "(", "[", { remap = true })
      vim.keymap.set({"n", "o", "x"}, ")", "]", { remap = true })
    end,
  },
  {
    -- asychronous task dispatcher
    -- TODO: replace with overseer.nvim?
    "tpope/vim-dispatch",
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
}
