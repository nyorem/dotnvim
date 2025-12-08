return {
  -- another toolbox
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true, notify = false },
    quickfile = { enabled = true },
    picker = {
      enabled = true,
      main = {
        file = false, -- allow to override current buffer with picked object
      },
      sources = {
        files = {
          layout = "ivy",
        },
        git_files = {
          layout = "ivy",
        },
        grep = {
          ignorecase = true,
        },
        git_grep = {
          ignorecase = true,
        },
      },
    },
  },
  }
}
