return {
  {
    -- better quickfix (filtering with <TAB>...)
    "kevinhwang91/nvim-bqf",
    config = function()
      require("bqf").setup({
          preview = {
            auto_preview = false,
          },
      })
    end,
  },
  {
    -- quickfix list as a buffer
    "stefandtw/quickfix-reflector.vim",
  }
}
