return {
  {
    -- magit like plugin
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "echasnovski/mini.pick",         -- optional
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup {
        disable_insert_on_commit = true,
        auto_refresh = true,
        process_spinner = false,
      }
      vim.keymap.set('n', '<Space>gg', function()
        local cwd_without_oil = string.gsub(vim.fn.expand("%:p:h"), "oil://", "")
        require("neogit").open({ cwd = cwd_without_oil })
      end, { desc = "Git status" })
    end,
  },
  {
    -- git information in buffers
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '>' },
          delete = { text = '-' },
          topdelete = { text = '^' },
          changedelete = { text = '<' },
        },
        current_line_blame_opts = {
          delay = 0,
        }
      }
      vim.keymap.set('n', '<Space>gB', ':Gitsigns toggle_current_line_blame<CR>', { desc = "Toggle git blame" })
    end,
  },
  {
    -- github integration
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup({
          enable_builtin = true,
          suppress_missing_scope = {
            projects_v2 = true,
          },
          file_panel = {
            use_icons = false,
          },
      })

      vim.keymap.set('n', '<Space>go', '<CMD>Octo<CR>', { desc = "Open Octo dashboard" })
      vim.keymap.set('n', '<Space>gpc', ':Octo search is:pr archived:false author:@me is:open<CR>', { desc = "List all the PRs I created" })
      vim.keymap.set('n', '<Space>gpa', ':Octo search is:pr archived:false assignee:@me is:open<CR>', { desc = "List all the PRs assigned to me" })
      vim.keymap.set('n', '<Space>gpm', ':Octo search is:pr archived:false mentions:@me is:open<CR>', { desc = "List all the PRs where I am mentioned" })
      vim.keymap.set('n', '<Space>gpr', ':Octo search is:pr archived:false review-requested:@me is:open<CR>', { desc = "List all the PRs where I am requested to review" })
      vim.keymap.set('n', '<Space>gpc', ':Octo pr create<CR>', { desc = "Create a PR" })
    end,
  },
  {
    -- when you need one more git helper
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<Space>gl", ":tab Git log<CR>", { desc = "Git log" })

      -- TODO: use lua instead?
      vim.cmd [[
      autocmd User FugitiveIndex nmap <buffer> p :Git push<CR>
      autocmd User FugitiveIndex nmap <buffer> P :Git push --force-with-lease<CR>
      autocmd User FugitiveIndex nmap <buffer> f :Git fetch<CR>
      autocmd User FugitiveIndex nmap <buffer> F :Git pull --rebase<CR>

      autocmd User FugitiveIndex nmap <buffer> l :tab Git log<CR>
      autocmd User FugitiveIndex nmap <buffer> <TAB> =
      autocmd User FugitiveIndex nmap <buffer> x X
      autocmd User FugitiveObject setlocal foldmethod=syntax nofoldenable
      autocmd User FugitiveObject,FugitiveIndex nnoremap <buffer> q :q<CR>
      ]]
    end,
  },
  {
    -- enable GBrowse
    "tpope/vim-rhubarb",
    config = function ()
    end
  },
  {
    -- git log integration in vim
    "junegunn/gv.vim",
    dependencies = {
      "tpope/vim-fugitive",
    },
    config = function ()
    end
  },
  {
    -- solve merge conflicts
    "akinsho/git-conflict.nvim",
    dependencies = {
      "tpope/vim-fugitive",
    },
    version = "*",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("git-conflict").setup({})

      vim.keymap.set("n", "<Space>gr", ":Gwrite<CR>", { desc = "Mark conflicts as resolved" })
    end,
  }
}
