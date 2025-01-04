return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = false,
  opts = {
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
    },
    -- remove the need of a NERD font
    cmdline = {
      format = {
        cmdline = { icon = ">" },
        search_down = { icon = "🔍⌄" },
        search_up = { icon = "🔍⌃" },
        filter = { icon = "$" },
        lua = { icon = "☾" },
        help = { icon = "?" },
      },
    },
    format = {
      level = {
        icons = {
          error = "✖",
          warn = "▼",
          info = "●",
        },
      },
    },
    popupmenu = {
      kind_icons = false,
    },
    inc_rename = {
      cmdline = {
        format = {
          IncRename = { icon = "⟳" },
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  }
}
