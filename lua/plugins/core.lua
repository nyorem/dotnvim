return {
  {
    "tpope/vim-endwise",
  },
  {
    "tpope/vim-eunuch",
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "tpope/vim-repeat",
  },
  {
    "tpope/vim-unimpaired",
    config = function()
      vim.keymap.set({"n", "o", "x"}, "(", "[", { remap = true })
      vim.keymap.set({"n", "o", "x"}, ")", "]", { remap = true })
    end,
  },
  {
    "tpope/vim-dispatch",
  },
  {
    'romainl/vim-cool',
  },
}
