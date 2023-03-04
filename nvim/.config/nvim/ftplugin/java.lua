lsp = require("lsp.java")

lsp.start({
    cmd = lsp.buildCmd(),
    root_dir = lsp.rootDir(),
    settings = lsp.settings(),
    init_options = lsp.initOptions(),
})
