local Util = require("util")

local function get_toggle_list_option(opt, val)
    return function()
        if Util.contains(vim.opt[opt]:get(), val) then
            vim.opt[opt]:remove(val)
        else
            vim.opt[opt]:append(val)
        end
    end
end

local function get_toggle_boolean_option(opt)
    return function()
        vim.opt[opt] = not vim.opt[opt]:get()
    end
end

local function get_toggle_string_option(opt, vals)
    assert(#vals > 1)
    local i = Util.contains(vals, vim.opt[opt]:get()) or 0
    return function()
        i = i % #vals + 1
        vim.opt[opt] = vals[i]
    end
end



local M = {}

M.dash_keyword = get_toggle_list_option("iskeyword", '-')
M.clipboard = get_toggle_list_option("clipboard", 'unnamedplus')

M.number = get_toggle_boolean_option("number")
M.relativenumber = get_toggle_boolean_option("relativenumber")
M.hlsearch = get_toggle_boolean_option("hlsearch")
M.spell = get_toggle_boolean_option("spell")

M.background = get_toggle_string_option("background", { "light", "dark" })

do
    local visual_line = 0
    local keys = { 'j', 'k', '0', '$' }
    function M.visual_line()
        visual_line = (visual_line + 1) % 2
        for _,k in ipairs(keys) do
            if visual_line == 1 then
                vim.keymap.set('n', k, 'g' .. k)
            else
                vim.keymap.del('n', k)
            end
        end
    end
end

do
    local id
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    local function create_highlight_yank_autocmd()
        return vim.api.nvim_create_autocmd('TextYankPost', {
            callback = function()
                vim.highlight.on_yank({
                    timeout = 100,
                })
            end,
            group = highlight_group,
            pattern = '*',
        })
    end

    id = create_highlight_yank_autocmd()
    function M.highlight_yank()
        if not id then
            id = create_highlight_yank_autocmd()
        else
            vim.api.nvim_del_autocmd(id)
            id = nil
        end
    end
end

do
    local diag_hidden = 0
    function M.diagnostics()
        diag_hidden = (diag_hidden + 1) % 2
        if diag_hidden == 1 then
            vim.diagnostic.disable()
        else
            vim.diagnostic.enable()
        end
    end
end



return M
