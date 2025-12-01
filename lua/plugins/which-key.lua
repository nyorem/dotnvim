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
      { "<Leader>c", group = "LSP" },
      { "<Leader>d", group = "Debugging" },
      { "<Leader>f", group = "Files" },
      { "<Leader>g", group = "Git" },
      { "<Leader>h", group = "Help" },
      { "<Leader>gp", group = "Github" },
      { "<Leader>p", group = "Projects" },
      { "<Leader>s", group = "Search & Sessions" },
      { "<Leader>t", group = "Terminal & Telescope & Testing" },
      { "<Leader>u", group = "Utilities" },
    })
  end,
}
