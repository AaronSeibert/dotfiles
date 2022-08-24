set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim " OS X
call vundle#begin()

Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'slim-template/vim-slim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'romkatv/powerlevel10k'
Plugin 'arcticicestudio/nord-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'qpkorr/vim-bufkill'

" Must be last!
Plugin 'ryanoasis/vim-devicons'
call vundle#end()

" lightline theme
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

colorscheme nord

filetype plugin indent on    " enable loading indent file for filetype

syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
set tabstop=4
set shiftwidth=4
set expandtab
set noshowmode

nnoremap <leader>v <Plug>TaskList
nnoremap <leader>q :bp<cr>:bd #<cr>

let g:NERDTreeWinPos = "right"
let g:NERDTreeStatusline = '%#NonText#'
let g:xmledit_enable_html=1


set foldmethod=indent
set foldlevel=9

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Autoclose HTML Tags
iabbrev </ </<C-X><C-O>


" Per-directory vimrc
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" Plugins to load on startup
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
