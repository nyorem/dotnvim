return {
  'stevearc/oil.nvim',
  config = function()
    -- Declare a global function to retrieve the current directory
    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = require("oil").get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ":~")
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end

    require("oil").setup({
        win_options = {
          winbar = "%!v:lua.get_oil_winbar()",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, bufnr)
            return name == "." or name == ".."
          end,
        },
        skip_confirm_for_simple_edits = true,
        -- change cwd when changing directory from oil
        -- https://github.com/stevearc/oil.nvim/issues/68
        keymaps = {
          ["<Esc>"] = { callback = "actions.close", mode = "n" },
          ["<C-p>"] = false,
          ["-"] = function()
            require("oil.actions").parent.callback()
            vim.cmd.lcd(require("oil").get_current_dir())
          end,
          ["<CR>"] = { function()
            require("oil").select(nil, function(err)
              if not err then
                local curdir = require("oil").get_current_dir()
                if curdir then
                  vim.cmd.lcd(curdir)
                end
              end
            end)
          end, desc = "Select" },
          ["<Space>y"] = {function()
            -- source: https://github.com/stevearc/oil.nvim/blob/fb8b101d7cb4727d8719ab6ed141330eca997d3f/lua/oil/actions.lua#L194
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
              return
            end
            vim.fn.setreg("+", dir .. entry.name)
          end, desc = "Copy path of entry under cursor into '+' register" },
          ["!"] = {function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
              return
            end
            local path = dir .. entry.name
            vim.fn.feedkeys(":")
            vim.fn.feedkeys("!")
            vim.fn.feedkeys(path)
            local go_to_beginning = vim.api.nvim_replace_termcodes("<Home><Right>", true, true, true)
            vim.fn.feedkeys(go_to_beginning)
          end, desc = "Start command line with a path under the cursor "},
        },
    })

    -- vim-vinegar like mapping to go up a directory
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- use <CR> to confirm and <ESC> to quit in a prompt
    -- https://github.com/stevearc/oil.nvim/issues/114#issuecomment-1571332722
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil_preview",
      callback = function(params)
        vim.keymap.set("n", "<CR>", "o", { buffer = params.buf, remap = true, nowait = true })
        vim.keymap.set("n", "<ESC>", "c", { buffer = params.buf, remap = true, nowait = true })
      end,
    })
  end,
}
