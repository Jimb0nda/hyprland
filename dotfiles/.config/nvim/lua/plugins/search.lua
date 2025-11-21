return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
                defaults = {
                    silent = true, -- hide startup/info messages
                },
                files = {
                    cwd_prompt = false,
                },
                grep = {
                    rg_opts = "--hidden --glob '!.git/**' --glob '!node_modules/**' --glob '!bin/**' --glob '!obj/**'",
                },
            })
            -- Keybinds similar to VS
            vim.keymap.set("n", "<C-f>", fzf.files, { desc = "Find files" })
            vim.keymap.set("n", "<C-,>", fzf.live_grep, { desc = "Live grep (project search)" })
        end,
    }
}
