local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Copying to system clipboard
-- From current cursor position to EOL (normal mode)
vim.keymap.set('n', '<C-c>', '"+y$')
-- Current selection (visual mode)
vim.keymap.set('v', '<C-c>', '"+y')

-- Cutting to system clipboard
-- From current cursor position to EOL (normal mode)
vim.keymap.set('n', '<C-x>', '"+d$')
-- Current selection (visual mode)
vim.keymap.set('v', '<C-x>', '"+d')

require("vim-options")
require("lazy").setup("plugins")

