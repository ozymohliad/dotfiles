local jdtls_jar  = vim.fn.expand('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')
local jdtls_config = '/usr/share/java/jdtls/config_linux/config.ini'

-- local lombok_paths = vim.fn.expand("~/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/*/*/lombok-1.18.??.jar", true, true)
-- local lombok_paths = vim.fn.expand("~/.m2/repository/org/projectlombok/lombok/1.18.??/lombok-1.18.??.jar", true, true)
-- local lombok_path = vim.fn.sort(lombok_paths, 'n')[#lombok_paths]
local lombok_path = vim.fn.expand('~/.local/share/nvim/lombok.jar')
-- local lombok_available = vim.fn.filereadable(lombok_path) == 1

local project_root = require('jdtls.setup').find_root({ '.git', 'gradlew', 'mvnw' }) or vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
local data_root = vim.fn.fnamemodify("~/.cache/jdtls/workspaces/", ":p")
local local_config_dir = vim.fn.fnamemodify("~/.cache/jdtls/config/", ":p")
local project_data_path = data_root .. project_root

os.execute(("mkdir -p '%s'"):format(project_data_path))
os.execute(("mkdir -p '%s'"):format(local_config_dir))
os.execute(("ln -sf '%s' '%s'"):format(jdtls_config, local_config_dir))

require('jdtls').start_or_attach({
    cmd = {
        '/usr/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. lombok_path,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_jar,
        '-configuration', local_config_dir,
        '-data', project_data_path,
    },
    root_dir = project_root,
    settings = {
        java = {
            project = {
            }
        }
    },
    init_options = {
        bundles = {}
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    pattern = "*.java",
    callback = function(_)
        vim.keymap.set('n', '<C-A-o>', require('jdtls').organize_imports)
        require("lsp_keymaps").on_attach(nil, 0)
    end,
})

vim.opt.expandtab = true
