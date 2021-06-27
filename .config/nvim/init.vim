"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set relativenumber
set cursorline
set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set autoindent
set lcs+=space:·
set hidden

set backup
set backupdir=$HOME/.config/nvim/backup
set directory=$HOME/.config/nvim/tmp

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'flw-cn/vim-nerdtree-l-open-h-close'
  Plug 'dyng/ctrlsf.vim'
call plug#end()

colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='luna'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(so|png|jpg|jpeg)$',
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=1

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
  \ exists('b:NERDTree') && b:NERDTree.isTabTree() |
  \ quit | endif
nnoremap <leader>n :NERDTreeFocus<CR>

" If more than one window and previous buffer was NERDTree,
" go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && 
  \ winnr('$') > 1 | b# | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapping for buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>q :bp <BAR> bd #<CR>

