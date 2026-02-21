return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/nvim-treesitter-locals',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'hiphish/rainbow-delimiters.nvim',
        },
        config = function()
            local treesitter = require('nvim-treesitter')
            treesitter.setup({
                install_dir = vim.fn.stdpath('data') .. '/treesitter'
            })

            treesitter.install({
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
                'go',
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = {'c', 'lua', 'java'},
                callback = function() vim.treesitter.start() end,
            })

            --     refactor = {
            --         highlight_definitions = {
            --             enable = true,
            --             clear_on_cursor_move = true,
            --         },
            --     },
            -- }
            --

            require("nvim-treesitter-textobjects").setup {
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
                        [']a'] = '@parameter.outer',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']A'] = '@parameter.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[a'] = '@parameter.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[A'] = '@parameter.outer',
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
            }

            require('rainbow-delimiters.setup').setup({
                strategy = {
                    [''] = require('rainbow-delimiters').strategy['global'],
                    vim  = require('rainbow-delimiters').strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua  = 'rainbow-blocks',
                },
                priority = {
                    [''] = 110,
                    lua  = 210,
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            })

            require('treesitter-context').setup({
                enable = true,
                max_lines = 1,
                min_window_height = 30,
            })

            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context()
            end, { silent = true })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            vim.g.no_plugin_maps = true
        end,
    },
}
