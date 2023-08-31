vim.lsp.start({
    name = 'haskell-lsp',
    cmd = { 'haskell-language-server', '--lsp', },
    root_dir = ".",
})
