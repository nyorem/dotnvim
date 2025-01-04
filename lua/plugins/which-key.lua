return {
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
      { "<Space>ca", desc = "Run code action" },
      { "<Space>cd", desc = "Go to definition" },
      { "<Space>cf", desc = "Format selected code" },
      { "<Space>cr", desc = "Find all references" },
      { "<Space>d", group = "Debugging" },
      { "<Space>dc", desc = "Continue debugging session" },
      { "<Space>dk", desc = "Restart Vimspector" },
      { "<Space>dt", desc = "Toggle breakpoint" },
      { "<Space>dT", desc = "Clear all breakpoints" },
      { "<Space>f", group = "Files" },
      { "<Space>g", group = "Git" },
      { "<Space>gl", desc = "Git log" },
      { "<Space>gg", desc = "Git status" },
      { "<Space>gp", group = "Github" },
      { "<Space>jp", group = "Pretty print JSON buffer" },
      { "<Space>m", desc = "Open man page" },
      { "<Space>p", group = "Projects" },
      { "<Space>s", group = "Search" },
      { "<Space>t", group = "Terminal" },
      { "<Space>v", group = "Vim" },
    })
  end,
}
