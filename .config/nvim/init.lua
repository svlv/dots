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

local configs = require'nvim-treesitter.configs'
configs.setup {
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },

    highlight = {
        enable = true
    },

    indent = {
      enable = false
    }
}

--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require("mason").setup()
require("mason-lspconfig").setup()

require("lspconfig").lua_ls.setup{}
--require("lspconfig").clangd.setup{}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', opts)
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', opts)
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', opts)

