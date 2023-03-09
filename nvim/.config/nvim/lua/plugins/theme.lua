local pluginName = "ellisonleao/gruvbox.nvim"
local themeName = 'gruvbox'

return {
    {
        pluginName,
        config = function()
            require("gruvbox").setup({
                contrast = 'soft',
            })
            vim.cmd.colorscheme(themeName)
        end,
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        dependencies = { pluginName, },
        opts = {
            options = {
                icons_enabled = false,
                theme = themeName,
                component_separators = '|',
                section_separators = { left = '', right = '' },
            },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = { pluginName, },
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },
}
