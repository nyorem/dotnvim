return {
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    config = function()
      require("tree-sitter-manager").setup({
        ensure_installed = { "bash", "c", "cmake", "cpp", "comment", "json", "lua", "markdown", "markdown_inline", "python", "query", "regex", "vim", "vimdoc", "yaml" },
      })
    end
  }
}
