local home = vim.env.HOME
local runtimeDir = home .. '/.config/nvim'

local tsitter = require('nvim-treesitter.configs')

tsitter.setup {
  ensure_installed = { },
  ignore_install = { "diff" },
  sync_install = false,
  auto_install = true,

  parser_install_dir = runtimeDir,

  highlight = {
    enable = true,
    disable = { "diff" },
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
