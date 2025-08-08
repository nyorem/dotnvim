return {
  -- don't forget your keybindings
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    require('which-key').setup {
      replace = {
        key = {
          { "<Space>", "SPC" },
          { "<CR>", "RET" },
          { "<tab>", "TAB" },
        },
      },
      icons = {
        mappings = false,
      },
    }

    local wk = require('which-key')

    wk.add({
      { "gc", group = "Comment" },
      { "<Space>c", group = "LSP" },
      { "<Space>d", group = "Debugging" },
      { "<Space>f", group = "Files" },
      { "<Space>g", group = "Git" },
      { "<Space>gp", group = "Github" },
      { "<Space>p", group = "Projects" },
      { "<Space>s", group = "Search" },
      { "<Space>t", group = "Terminal & Telescope" },
    })
  end,
}
