local jdtlsRoot      = '/usr/share/java/jdtls'
local javaAgentPath  = vim.fn.expand("$HOME/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.24/13a394eed5c4f9efb2a6d956e2086f1d81e857d9/lombok-1.18.24.jar")
local lspJarPath     = jdtlsRoot .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
local configPath     = jdtlsRoot .. '/config_linux/config.ini'
local localDataDir   = vim.fn.expand("$HOME/.cache/jdtls")
local localConfigDir = vim.fn.expand("$HOME/.cache/jdtls/config")

os.execute(("mkdir -p '%s'"):format(localConfigDir))
os.execute(("ln -sf '%s' '%s'"):format(configPath, localConfigDir))

require('jdtls').start_or_attach({
    cmd = {
        '/usr/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. javaAgentPath,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', lspJarPath,
        '-configuration', localConfigDir,
        '-data', localDataDir,
    },
    root_dir = require('jdtls.setup').find_root({ '.git' }),
    settings = {
        java = {
        }
    },
    init_options = {
        bundles = {}
    },
})


vim.api.nvim_create_autocmd('LspAttach', {
    pattern = "*.java",
    callback = function(args)
        vim.keymap.set('n', '<C-A-o>', require('jdtls').organize_imports)
        require("lsp").on_attach(nil, 0)
    end,
})
