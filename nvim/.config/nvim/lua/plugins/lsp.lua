return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'Decodetalkers/csharpls-extended-lsp.nvim', },
        config = function()
            local servers = {
                texlab = {},
                omnisharp = {},
                clangd = {},
                ts_ls = {},
                pyright = {},
                rust_analyzer = {
                    autostart = false,
                    rustfmt = {
                        rangeFormatting = {
                            enable = true,
                        }
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            runtime = { version = 'Lua 5.4' },
                        },
                    },
                },
                csharp_ls = {
                    handlers = {
                        ["textDocument/definition"] = require('csharpls_extended').handler,
                        ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
                    },
                },
                hls = {
                    -- use system lsp instead of the one installed by mason
                    cmd = { 'haskell-language-server', '--lsp', },
                },
                -- gopls = {
                -- },
            }

            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup({
                -- ensure_installed = vim.tbl_keys(servers),
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            for server, config in pairs(servers) do
                config.capabilities = capabilities
                config.on_attach = require("lsp").on_attach
                vim.lsp.config(server, config)
            end
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        config = function()
            require('lazydev').setup({
                library = {
                    { path = "~/github/fivem-lls-addon/library", words = { "Citizen" } },
                },
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
            vim.keymap.set("n", "<leader>gq", vim.lsp.buf.format, { desc = "Format current buffer" })
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        config = function()
            local luasnip = require('luasnip')
            luasnip.config.setup({})
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                view = {
                    entries = "custom"
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { 'abbr', 'kind', 'menu' },
                    format = require('lspkind').cmp_format({
                        mode = "symbol_text",
                        menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            calc = "[Calc]",
                        })
                    }),
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<A-j>'] = cmp.mapping.scroll_docs(1),
                    ['<A-k>'] = cmp.mapping.scroll_docs(-1),
                    ['<Tab>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                }),
                sources = cmp.config.sources(
                    {
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                    },
                    {
                        { name = 'buffer' },
                        { name = 'calc' },
                    }
                ),
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    {
                        { name = 'path' }
                    },
                    {
                        { name = 'cmdline' }
                    }
                ),
                matching = {
                    disallow_symbol_nonprefix_matching = false
                },
            })
        end,
    },
}
