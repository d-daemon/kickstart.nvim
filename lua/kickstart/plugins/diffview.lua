vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Open Git diff' })
vim.keymap.set('n', '<leader>gD', '<cmd>DiffviewClose<cr>', { desc = 'Close Git diff' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Current file Git history' })
