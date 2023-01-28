local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    '/usr/bin/java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:/home/sanya/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.22/9c08ea24c6eb714e2d6170e8122c069a0ba9aacf/lombok-1.18.22.jar',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/home/sanya/tmp/config',
    '-data', '/home/sanya/tmp',
  },

  root_dir = require('jdtls.setup').find_root({'.git'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
        signatureHelp = { enabled = true },
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
local jdtls = require('jdtls')
jdtls.start_or_attach(config)

local mapOpts = { noremap = true }
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', '<C-A-o>', jdtls.organize_imports, mapOpts)
        vim.keymap.set('n', '<C-A-CR>', vim.lsp.buf.code_action, mapOpts)
        vim.keymap.set('n', '<C-A-h>', vim.lsp.buf.hover, mapOpts)
        vim.keymap.set('n', '<C-A-r>', vim.lsp.buf.rename, mapOpts)
    end,
})

--[[
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "help" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  parser_install_dir = "/home/sanya/tmp/treesitter", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    disable = { "c", "rust" },
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}
--]]
