return {
  {
    'saghen/blink.cmp',
    version = 'v0.8.2',
    opts = {
      keymap = { preset = 'super-tab' },
      completion = {
        menu = {
          -- https://github.com/Saghen/blink.cmp/issues/802
          -- should be fixed when updating to a newer version
          auto_show = function()
            return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.bo.filetype ~= "TelescopePrompt"
          end,
        },
      },
    },
  },
  {
    "github/copilot.vim",
  },
}
