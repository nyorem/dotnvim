return {
    name = "CMake configure",
    params = {
        build_type = {
            type = "enum",
            name = "Build type",
            order = 2,
            optional = false,
            choices = { "debug", "release" },
        },
        extra_cmake_args = {
            type = "string",
            name = "Extra CMake args",
            order = 3,
            optional = false
        },
    },
    builder = function(params)
        local cmake_utils = require("utils.cmake")
        local project_dir = cmake_utils.get_project_dir()
        local build_dir = cmake_utils.get_main_build_dir()
        build_dir:mkdir({ parents = true })

        local args = {
            "-G Unix Makefiles",
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
            "-DENABLE_STANDALONE=ON",
            "-DENABLE_TEST=ON",
            "-DENABLE_DM=ON",
            "-DENABLE_SRR=ON",
            "-DREST_API_VERSION=2",
            "-DENABLE_GTEST_DISCOVER=ON",
            cmake_utils.generate_cmake_build_type_param(params.build_type),
        }

        if params.extra_cmake_args ~= "" then
            table.insert(args, params.extra_cmake_args)
        end

        args = vim.tbl_extend("force", args, {
            "-S",
            tostring(project_dir),
            "-B",
            tostring(build_dir),
        })

        return {
            name = "cmake_configure",
            cmd = { "cmake" },
            args = args,
            components = {
                { "on_complete_notify" },
                { "on_exit_set_status" },
                { "on_output_quickfix",          open = true, set_diagnostics = true, tail = true },
                -- { "open_output",                 direction = "tab", focus = false, on_complete = "failure" },
                { "unique",                      replace = true },
            },
        }
    end,
}
