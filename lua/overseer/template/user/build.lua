return {
    name = 'Build target',
    params = {
        target = {
            type = "string",
            name = "Target",
            order = 1,
            optional = false,
        },
        jobs = {
            type = "integer",
            name = "Jobs",
            order = 2,
            optional = false,
        },
    },
    builder = function(params)
        local cmake_utils = require("utils.cmake")
        local build_dir = cmake_utils.get_main_build_dir()
        local target = params.target

        return {
            cmd = { 'cmake' },
            args = {
                '--build',
                tostring(build_dir),
                '--target',
                target,
                '-j',
                params.jobs,
            },
            name = 'build',
            components = {
                { "on_complete_notify" },
                { "on_exit_set_status" },
                { "on_output_quickfix",  open = true, tail = true },
                -- { "open_output",         direction = "tab", focus = false, on_complete = "failure" },
                { "unique",              replace = true },
            }
        }
    end,
}
