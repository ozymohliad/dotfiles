local home = vim.env.HOME

local javaPath       = '/usr/bin/java'
local javaAgentPath  = home .. '/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.24/13a394eed5c4f9efb2a6d956e2086f1d81e857d9/lombok-1.18.24.jar' 
local lspJarPath     = '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
local configPath     = '/usr/share/java/jdtls/config_linux/config.ini'
local localDataDir   = home .. '/.cache/jdtls'
local localConfigDir = localDataDir .. '/config'

os.execute(("mkdir -p '%s'"):format(localConfigDir))
os.execute(("ln -sf '%s' '%s'"):format(configPath, localConfigDir))

local module = {}

module.jdtls = require('jdtls')

-- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
function module.buildCmd()
    return {
        javaPath,
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
    }
end

function module.rootDir()
  return require('jdtls.setup').find_root({'.git'})
end

-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
function module.settings()
    return {
        java = {
            signatureHelp = { enabled = true },
        }
    }
end

-- Language server `initializationOptions`
-- You need to extend the `bundles` with paths to jar files
-- if you want to use additional eclipse.jdt.ls plugins.
--
-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--
-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
function module.initOptions()
    init_options = {
        bundles = {}
    }
end

function module.start(config)
    module.jdtls.start_or_attach(config)
end

local function mappings()
    vim.keymap.set('n', '<C-A-o>',  module.jdtls.organize_imports)
    vim.keymap.set('n', '<C-A-CR>', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<C-A-h>',  vim.lsp.buf.hover)
    vim.keymap.set('n', '<C-A-r>',  vim.lsp.buf.rename)
end

vim.api.nvim_create_autocmd('LspAttach', { callback = mappings })

return module
