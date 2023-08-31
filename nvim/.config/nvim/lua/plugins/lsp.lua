return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'Hoffs/omnisharp-extended-lsp.nvim',
        },
        config = function()
            local servers = {
                omnisharp = {},
                pyright = {},
                rust_analyzer = {},
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        runtime = { version = 'Lua 5.4' },
                    },
                },
            }

            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = require("lsp").on_attach,
                        settings = servers[server_name],
                    }
                end,
            }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'Hoffs/omnisharp-extended-lsp.nvim',

            { 'j-hui/fidget.nvim', opts = {} },

            {
                'folke/neodev.nvim',
                config = function()
                    require('neodev').setup()
                end
            },
        },
    },
    {
        'L3MON4D3/LuaSnip',
        config = function()
            local luasnip = require('luasnip')
            luasnip.config.setup({})
        end,
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                        ['<C-j>'] = cmp.mapping.select_next_item(),
                        ['<C-k>'] = cmp.mapping.select_prev_item(),
                        ['<A-j>'] = cmp.mapping.scroll_docs(1),
                        ['<A-k>'] = cmp.mapping.scroll_docs(-1),
                        ['<Tab>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            })
        end,
    },
}
