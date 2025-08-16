return {
  -- custom submodes and menus (clone of emacs hydra package)
  "nvimtools/hydra.nvim",
  enabled = false,
  dependencies = {
  },
  config = function()
    local Hydra = require("hydra")

    -- window management
    Hydra({
      name = "Change / Resize Windows",
      mode = { "n" },
      body = "<C-w>",
      hint = [[
Move         Resize
_h_: Left     _H_: Left
_l_: Right    _L_: Right
_k_: Up       _K_: Up
_j_: Down     _J_: Down
_Q_: Close    _e_: Equalize

_q_ or _<Esc>_: Exit]],
      heads = {
        { "h", "<C-w>h" },
        { "l", "<C-w>l" },
        { "k", "<C-w>k" },
        { "j", "<C-w>j" },
        { "Q", ":q<cr>" },

        { "H", "<C-w>3<" },
        { "L", "<C-w>3>" },
        { "K", "<C-w>2+" },
        { "J", "<C-w>2-" },
        { "e", "<C-w>=" },

        { "q", nil, { exit = true, nowait = true } },
        { "<Esc>", nil, { exit = true, nowait = true } },
      },
    })
  end,
}
