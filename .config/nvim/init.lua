home_dir = os.getenv("HOME") 

vim.o.mouse = 'a'

vim.go.backup = true
vim.go.backupdir = home_dir .. '/.config/nvim/backup'
vim.go.dir = home_dir .. '/.config/nvim/tmp'

vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.o.list = true
vim.o.listchars = 'space:·'
vim.wo.colorcolumn = '80'

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true

--vim.bo.textwidth = 80
-- set hidden

require('plugins')

vim.cmd [[colorscheme catppuccin-mocha]]

-- Airline
vim.g.airline_theme = 'violet'
vim.cmd([[let g:airline#extensions#tabline#enabled = 1]])
vim.cmd([[let g:airline#extensions#tabline#fnamemod = ':t']])

vim.api.nvim_set_keymap('n', '<leader>l', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', ':CtrlP<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true, silent = true })

vim.g.ctrlp_working_path_mode = 'r'
vim.cmd([[
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(so|png|jpg|jpeg)$',
\}
]])

