return {
  -- toolbox
  "echasnovski/mini.nvim",
  config = function()
    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = false })

    require('mini.ai').setup()
    require('mini.indentscope').setup()
    require('mini.move').setup()
    require("mini.operators").setup({ replace = { prefix = '' }})
    require('mini.pairs').setup({
        mappings = {
          ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%w\\].', register = { cr = false } },
          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w\\].', register = { cr = false } },
        }
      })
    require('mini.splitjoin').setup()
    require('mini.surround').setup()
  end,
}
