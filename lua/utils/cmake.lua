local M = {}

function M.generate_cmake_build_type_param(build_type)
    if build_type == "release" then
        return "-DCMAKE_BUILD_TYPE=Release"
    elseif build_type == 'debug' then
        return "-DCMAKE_BUILD_TYPE=Debug"
    end
end

function M.get_project_dir()
    return require('plenary.path'):new(vim.fn.getcwd())
end

function M.get_main_build_dir()
    return M.get_project_dir() / "build"
end

return M
