return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pylsp",
                    "csharp_ls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.clangd.setup({
                capabilities = capabilities
            })
            lspconfig.pylsp.setup({
                capabilities = capabilities
            })
            lspconfig.csharp_ls.setup({
                capabilities = capabilities
            })
            -- Common LSP keybinds:
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  {}) -- Go to definition
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {}) -- Go to declaration
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {}) -- Go to implementation
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {}) -- Find references
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})      -- Hover documentation
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {}) -- Rename symbol
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {}) -- Code actions
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {}) -- Prev diagnostic
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {}) -- Next diagnostic
        end
    },
}
