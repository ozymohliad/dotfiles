return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'c',
                'cpp',
                'java',
                'lua',
                'python',
                'rust',
                'vimdoc',
                'vim',
                'query',
                'sql',
            },
            auto_install = false,

            highlight = { enable = true },
            indent = { enable = true, disable = { 'python' } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<leader>v',
                    node_incremental = 'gni',
                    node_decremental = 'gnd',
                    scope_incremental = 'gsi',
                },
            },
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                    },
                    include_surrounding_whitespace = true,
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                            [']f'] = '@function.outer',
                    },
                    goto_next_end = {
                            [']F'] = '@function.outer',
                    },
                    goto_previous_start = {
                            ['[f'] = '@function.outer',
                    },
                    goto_previous_end = {
                            ['[F'] = '@function.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        }

        require('treesitter-context').setup({
            enable = true,
            max_lines = 2,
            min_window_height = 30,
        })

        vim.keymap.set("n", "[c", function()
            require("treesitter-context").go_to_context()
        end, { silent = true })
    end,
}
