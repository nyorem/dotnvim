return {
  -- another toolbox
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true, notify = false },
    quickfile = { enabled = true },
    -- to grep into results:
    -- - query -- <rg args> where <rg args> = *.lua or -ig *.lua or -g subdirector/** for example
    -- - <c-g> to go into live mode and .lua or !.lua
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
  }
}
