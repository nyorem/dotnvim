return {
  "echasnovski/mini.nvim",
  config = function()
    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = true })

    require('mini.ai').setup()
    require('mini.indentscope').setup()
    require('mini.move').setup()
    require("mini.operators").setup({ replace = { prefix = '' } })
    require('mini.pairs').setup()
    require('mini.splitjoin').setup()
    require('mini.surround').setup()
  end,
}
