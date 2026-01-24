-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("config.base")
require("config.autocmds")
require("config.filetype")
require("config.wsl")
require("config.marks")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "utils.snacks.pickers" },
  },
  install = {
    missing = true,
    colorscheme = { "habamax" }
  },
  change_detection = { enabled = false, notify = false },
  rocks = { enabled = false },
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      -- Stuff I don't use
      disabled_plugins = {
        'netrwPlugin',
        'tohtml',
        'tutor',
      },
    },
  },
})
