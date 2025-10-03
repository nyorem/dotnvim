return {
  {
     -- LSP and code formatting
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      'stevearc/conform.nvim',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- disable virtual text for diagnostics by default
      vim.diagnostic.config {
        virtual_text = false,
        underline = false,
        signs = true,
      }

      -- blink
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({"lua_ls"})

      -- c/cpp
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "-j=1",
          "-background-index",
          "--malloc-trim",
        },
        capabilities = capabilities,
      })
      vim.lsp.enable({"clangd"})

      -- python
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })
      vim.lsp.enable({"pyright"})

      -- markdown
      vim.lsp.config("marksman", {
        capabilities = capabilities,
      })
      vim.lsp.enable({"marksman"})

      -- key mappings
      vim.keymap.set("n", "<Space>cs", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch between header and source file" })
      vim.keymap.set("n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Run code action" })
      vim.keymap.set("n", "<Space>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
      vim.keymap.set("n", "<Space>cr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find all references" })

      vim.keymap.set("n", "<Space>co", vim.diagnostic.open_float, { desc = "Open diagnostics in floating window" })

      vim.keymap.set("n", "<Space>ct", function()
        local current = vim.diagnostic.config()
        vim.diagnostic.config({
          virtual_text = not current.virtual_text,
          underline = not current.underline,
          signs = not current.signs,
        })
      end, { desc = "Toggle diagnostics" })

      -- code formatting
      require("conform").setup({
          formatters_by_ft = {
            cpp = { "clang-format" },
            python = {
              -- To fix auto-fixable lint errors.
              "ruff_fix",
              -- To run the Ruff formatter.
              "ruff_format",
              -- To organize the imports.
              "ruff_organize_imports",
            }
          },
      })
      vim.keymap.set({"n", "v"}, "<Space>cf", function() require("conform").format() end, { desc = "Format selected code"} )
    end,
  },
  {
    -- show diagnostics in quickfix list
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<Space>cx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
    config = function()
      require("trouble").setup({})
    end
  }
}
