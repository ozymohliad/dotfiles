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
        'ozymohliad/lualine.nvim',
        dependencies = { pluginName, },
        opts = {
            options = {
                icons_enabled = false,
                theme = themeName,
                component_separators = '|',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        shorting_target = 80,
                    },
                },
            },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = { pluginName, },
        main = "ibl",
        opts = {
            indent = { char = '┊', },
            scope = { enabled = false, },
        },
    },
}
