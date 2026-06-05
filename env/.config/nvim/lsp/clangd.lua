return {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { '.git', 'build.sh', 'compile_commands.json', 'CMakeLists.txt' },
    settings = {
        clangd = {
            compilationDatabaseDirectory = '.build',
            fallbackFlags = { '-std=c++26' },
        },
    },
}
