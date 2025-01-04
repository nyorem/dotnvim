return {
  "echasnovski/mini.nvim",
  config = function()
    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = true })

    require('mini.ai').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.surround').setup()
    require('mini.pairs').setup()
  end,
}
