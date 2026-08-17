local M = {}

-- Resolve the directory of the current buffer, handling special buffers
-- like oil:// where the buffer name is a URL rather than a real path.
function M.get_current_dir()
    local ok, oil = pcall(require, "oil")
    if ok and vim.bo.filetype == "oil" then
        local d = oil.get_current_dir()
        if d and d ~= "" then return d end
    end
    local file = vim.api.nvim_buf_get_name(0)
    if file ~= "" and not file:match("^%w+://") then
        return vim.fn.fnamemodify(file, ":h")
    end
    return vim.fn.getcwd()
end

return M
