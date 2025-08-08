return {
  -- context aware syntax highlighting
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "bash", "c", "cpp", "comment", "json", "lua", "markdown", "markdown_inline", "python", "query", "regex", "vim", "vimdoc", "yaml" },
      -- auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, buf)
            if lang == "bitbake" then return true end
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },
  }
  end,
}
