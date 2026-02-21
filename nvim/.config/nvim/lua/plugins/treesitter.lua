local function map_select_textobject(keys, textobject)
    vim.keymap.set({ "x", "o" }, keys, function()
        require "nvim-treesitter-textobjects.select".select_textobject(textobject, "textobjects")
    end)
end

local function map_swap_next_textobject(keys, textobject)
    vim.keymap.set("n", keys, function()
        require("nvim-treesitter-textobjects.swap").swap_next(textobject)
    end)
end

local function map_swap_prev_textobject(keys, textobject)
    vim.keymap.set("n", keys, function()
        require("nvim-treesitter-textobjects.swap").swap_previous(textobject)
    end)
end

local function map_goto_next_start_textobject(keys, textobject)
    vim.keymap.set({ "n", "x", "o" }, keys, function()
        require("nvim-treesitter-textobjects.move").goto_next_start(textobject, "textobjects")
    end)
end

local function map_goto_prev_start_textobject(keys, textobject)
    vim.keymap.set({ "n", "x", "o" }, keys, function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(textobject, "textobjects")
    end)
end

local function map_goto_next_end_textobject(keys, textobject)
    vim.keymap.set({ "n", "x", "o" }, keys, function()
        require("nvim-treesitter-textobjects.move").goto_next_end(textobject, "textobjects")
    end)
end

local function map_goto_prev_end_textobject(keys, textobject)
    vim.keymap.set({ "n", "x", "o" }, keys, function()
        require("nvim-treesitter-textobjects.move").goto_previous_end(textobject, "textobjects")
    end)
end

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
                    lookahead = true,
                    selection_modes = {
                        -- 'v' charwise
                        -- 'V' linewise
                        -- '<c-v>' blockwise
                        ['@function.inner'] = 'v',
                    },
                    include_surrounding_whitespace = function(arg)
                        -- arg.query_string
                        -- arg.selection_mode
                        return arg.query_string ~= '@function.inner'
                    end,
                },
                move = {
                    set_jumps = true, -- whether to set jumps in the jumplist
                },
            }

            map_select_textobject("af", "@function.outer")
            map_select_textobject("if", "@function.inner")
            map_select_textobject("aa", "@parameter.outer")
            map_select_textobject("ia", "@parameter.inner")

            map_swap_next_textobject("<leader>al", "@parameter.inner")
            map_swap_prev_textobject("<leader>ah", "@parameter.inner")

            map_goto_next_start_textobject("]a", "@parameter.inner")
            map_goto_next_end_textobject("]A", "@parameter.inner")
            map_goto_prev_start_textobject("[a", "@parameter.inner")
            map_goto_prev_end_textobject("[A", "@parameter.inner")
            map_goto_next_start_textobject("]f", "@function.inner")
            map_goto_next_end_textobject("]F", "@function.inner")
            map_goto_prev_start_textobject("[f", "@function.inner")
            map_goto_prev_end_textobject("[F", "@function.inner")

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
