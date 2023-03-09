return {
    {
        'kylechui/nvim-surround',
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },
}
