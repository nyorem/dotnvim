return {
  {
    -- magit like plugin
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup {
        disable_insert_on_commit = true,
        auto_refresh = true,
        process_spinner = false,
      }
      vim.keymap.set('n', '<Leader>gg', function()
        local dir = require("utils.toolbox").get_current_dir()
        vim.cmd.lcd(dir)

        if vim.bo.filetype == "oil" then
          local cwd_without_oil = string.gsub(vim.fn.expand("%:p:h"), "oil://", "")
          require("neogit").open({ cwd = cwd_without_oil })
        else
          require("neogit").open()
        end
      end, { desc = "Git status" })
    end,
  },
  {
    -- git information in buffers
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require('gitsigns')

      gitsigns.setup {
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
      vim.keymap.set('n', '<Leader>gB', gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })

      vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage hunk" })
      vim.keymap.set('v', '<Leader>gs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Stage lines" })

      vim.keymap.set('n', '<leader>gS', gitsigns.reset_hunk, { desc = "Reset hunk" })
      vim.keymap.set('v', '<Leader>gS', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Reset lines" })
    end,
  },
  {
    "emrearmagan/atlas.nvim",
    dependencies = {
      "MeanderingProgrammer/render-markdown.nvim",
      "esmuellert/codediff.nvim",
    },
    opts = {
      pulls = {
        diff = {
          open_cmd = "CodeDiff",
        },
        repo_config = {
          paths = {
            ["etn-electrical/*"] = "/home/eaton/dev/eaton/*"
          },
        },
        providers = {
          github = {},
        },
      },
      issues = {
        providers = {
          jira = {
            base_url = os.getenv("JIRA_BASE_URL"),
            email = os.getenv("JIRA_EMAIL"),
            token = os.getenv("JIRA_TOKEN"),
          },
        },
      },
    },
    keys = {
      { '<Leader>gi', '<CMD>AtlasIssues<CR>', desc = "List all the issues I'm involved in" },
      { '<Leader>gp', '<CMD>AtlasPulls<CR>', desc = "List all the PRs I'm involved in" },
      { '<Leader>gP', '<CMD>AtlasCreatePR<CR>', desc = "Create a PR" },
    },
  },
  {
    -- when you need one more git helper
    -- <range>Gclog = commit history for selection (use 0 for whole file)
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<Leader>gl", ":tab Git log<CR>", { desc = "Git log" })

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
    enabled = false,
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

      vim.keymap.set("n", "<Leader>gw", ":Gwrite<CR>", { desc = "Mark conflicts as resolved" })
    end,
  },
  {
    "afonsofrancof/worktrees.nvim",
    event = "VeryLazy",
    opts = {
      base_path = ".",
      mappings = {
        delete = "<leader>wd",
      },
    },
  },
  {
    -- Explorer key bindings:
    -- za = toggle fold under cursor 
    -- zA = toggle all folds under cursor
    -- zM = close all folds
    -- zR = open all folds
    -- t switches from inline to side by side diff
    -- i switches from tree to list view
    --
    -- Common use cases:
    -- * git diff: CodeDiff <branchA> <branchB>
    -- * PR-like diff: CodeDiff <branchA>...<branchB>
    -- * file comparison: CodeDiff file a b
    -- * directory comparison: CodeDiff dir a b
    -- * file history: CodeDiff history HEAD~10 %
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      diff = {
        layout = "inline",
      },
      explorer = {
        view_mode = "tree",
      },
    },
  },
}
