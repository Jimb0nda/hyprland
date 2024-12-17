vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set('n', '<M-Left>', ':wincmd Left<CR>')
vim.keymap.set('n', '<M-Right>', ':wincmd Right<CR>')
vim.keymap.set('n', '<M-Up>', ':wincmd Uo<CR>')
vim.keymap.set('n', '<M-Down>', ':wincmd Down<CR>')
