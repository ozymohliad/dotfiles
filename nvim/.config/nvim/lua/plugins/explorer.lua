return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                    },
                    mappings = {
                        i = {
                            ['<A-k>'] = require("telescope.actions").preview_scrolling_up,
                            ['<A-j>'] = require("telescope.actions").preview_scrolling_down,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
                },
            }

            vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = 'Find [r]ecently opened files' })
            vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = 'Find existing [b]uffers' })
            vim.keymap.set('n', '<leader>s/', function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search [F]iles' })
            vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search [H]elp' })
            vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current [W]ord' })
            vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by [G]rep' })
            vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search [D]iagnostics' })
        end
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
        config = function()
            pcall(require('telescope').load_extension, 'fzf')
        end,
    },

}
