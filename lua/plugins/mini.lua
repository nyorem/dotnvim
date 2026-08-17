return {
  -- toolbox
  "echasnovski/mini.nvim",
  config = function()
    -- enhanced statusline
    local statusline = require("mini.statusline")
    statusline.setup({ use_icons = false })

    -- enhance some text objects (an = around next, al = around last...)
    local ai = require('mini.ai')
    ai.setup({
      custom_textobjects = {
        -- treesitter-based function/class text objects:
        -- aF/iF = around/inside function, aC/iC = around/inside class
        F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        C = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
      },
    })

    -- nerd icons
    require('mini.icons').setup({ style = "glyph" })

    -- indent scope indicator
    require('mini.indentscope').setup()

    -- move lines or visual selection with <M-hjkl>
    require('mini.move').setup()

    -- new operators:
    -- * cx to exchange text
    -- * g= to evaluate text
    -- * gm to multiply text
    -- * gs to sort text
    require("mini.operators").setup({
      exchange = { prefix = 'cx' },
      replace = { prefix = '' },
    })

    -- split and join objects with gS
    require('mini.splitjoin').setup()

    -- surround objects with sa (add), sd (delete), sr (replace), sh (highlight), sf/sF (find left/right)
    require('mini.surround').setup()
  end,
}
