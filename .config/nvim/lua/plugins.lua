return require('packer').startup(function()
    use { "wbthomason/packer.nvim" }
    use { "morhetz/gruvbox" }
    use { 'vim-airline/vim-airline' }
    use { 'vim-airline/vim-airline-themes' }
    use { 'junegunn/fzf.vim' }
    use { 'scrooloose/nerdtree' }
    use { 'dyng/ctrlsf.vim' }
    use { 'kien/ctrlp.vim' }
    use { "catppuccin/nvim", as = "catppuccin" }
end)
