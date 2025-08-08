return {
  {
    -- lightning fast completion
    'saghen/blink.cmp',
    version = 'v1.6.0',
    opts = {
      keymap = { preset = 'super-tab' },
    },
  },
  {
    -- your best AI coding assistant
    "github/copilot.vim",
    config = function()
      -- do not use <tab> for accepting suggestions as it conflicts with autocompletion
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
}
