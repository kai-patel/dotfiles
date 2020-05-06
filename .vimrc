"VIM CONFIG

set nocompatible

"Colour Scheme
colorscheme peachpuff

"Row numbers
set number
"set cursorline
set relativenumber 

"Show whitespace
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

"Show commands, enable menu
set showcmd
set wildmenu

"Only draw when needed
set lazyredraw

"Highlight searches, incremental search
set showmatch
set incsearch

"Tabs over spaces
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

"Set utf-8 compatibility
set encoding=utf-8

"Enable splitting directions
set splitbelow
set splitright

"Enable folding
set foldmethod=indent
set foldlevel=99

"Moving between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Toggle folds
nnoremap <space> za

"Enable syntax completion
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
syntax enable
