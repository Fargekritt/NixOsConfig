vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
require('which-key').register {
  ['<leader>p'] = { name = '[P]refix', v = { 'Open file explorer' } },
}
