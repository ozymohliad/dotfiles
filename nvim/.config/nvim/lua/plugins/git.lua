vim.api.nvim_create_user_command(
    'Browse',
    function(opts)
        vim.fn.system { 'xdg-open', opts.fargs[1] }
    end,
    { nargs = 1 }
)

return {
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    }
}
