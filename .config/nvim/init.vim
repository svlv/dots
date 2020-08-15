"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set number
set cursorline
set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set autoindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'
	Plug 'mcchrish/nnn.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'dyng/ctrlsf.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set up swap and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set directory=$HOME/tools/nvim/tmp
set backupdir=$HOME/tools/nvim/backup
set backup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gruvbox
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colo gruvbox 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='violet'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nnn
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nnn#set_default_mappings = 0
let g:nnn#command = 'nnn -H'
nnoremap <silent> <leader>nn :NnnPicker '%:p:h'<CR>
"let g:nnn#layout = 'vnew' " or vnew, tabnew etc.
let g:nnn#layout = {
      \ 'window': {
      \ 'width': 0.9,
      \ 'height': 0.6,
      \ 'highlight': 'Debug' }}
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

