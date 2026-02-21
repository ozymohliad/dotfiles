return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dap = require('dap')
            local ui = require('dapui')

            ui.setup()
        end,
    },
}
