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
      vim.cmd [[
        nmap ( [
        nmap ) ]
        omap ( [
        omap ) ]
        xmap ( [
        xmap ) ]
      ]]
    end,
  },
  {
    "tpope/vim-dispatch",
  },
}
