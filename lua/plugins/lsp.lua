return {
  {
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
      require("lspconfig").lua_ls.setup { capabilities = capabilities }

      -- c/cpp
      require("lspconfig").clangd.setup {
        cmd = {
          "clangd",
          "-j=1",
          "-background-index",
          "--malloc-trim",
        },
        capabilities = capabilities,
      }

      -- key mappings
      vim.keymap.set("n", "<Space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      vim.keymap.set("n", "<Space>cd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      vim.keymap.set("n", "<Space>cr", "<cmd>lua vim.lsp.buf.references()<CR>")

      -- code formatting
      require("conform").setup({
          formatters_by_ft = {
            cpp = { "clang-format" },
          },
      })
      vim.keymap.set({"n", "v"}, "<Space>cf", function() require("conform").format() end)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<Space>cm",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
    config = function()
      require("trouble").setup({})
    end
  }
}
