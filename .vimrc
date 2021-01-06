" VIM CONFIG

set nocompatible

" Colour Scheme
"colorscheme elflord (dark scheme)
colorscheme ron

" Ensure colorscheme accuracy
:set t_Co=256

" Subfolder searching (can be slow)
:set path+=**

" Set colorcolumn
set colorcolumn=

" Row numbers
set number
set cursorline
set relativenumber

" Show whitespace
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show commands, enable menu
set showcmd
set wildmenu

" Only draw when needed
set lazyredraw

" Highlight matching braces
set showmatch

" No highlight searches, incremental search
set incsearch
set nohlsearch

" Tabs over spaces
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

" Proper backspacing
set backspace=indent,eol,start

" Set utf-8 compatibility
set encoding=utf-8

" Enable splitting directions
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Moving between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Toggle folds
nnoremap <space> za

" Enable syntax completion
filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
syntax enable

" Sort completions by descending length
set completeopt+=longest

" Always show the autocompelete window when completing
set completeopt+=menuone

" Enable preview info for autocompletion
set completeopt+=preview

" Filetype-specific commands for each time a file is saved
"augroup python_settings " {
"    autocmd!
"    autocmd FileType python compiler pylint
"    autocmd BufWritePost *.py :make %
"augroup END " }

" Some settings for muComplete plugin
set completeopt+=noinsert   " alternatively use: set completeopt+=noselect

" Recommended settings for muComplete plugin
"set shortmess+=c "disable completion messages
"set belloff+=ctrlg "if bell rings during completion
"let g:mucomplete#enable_auto_at_startup = 1 "enable on startup

" muComplete popup delay
"let g:mucomplete#completion_delay = 1

" Swap g(j/k) and j/k for easier editing
nnoremap j gj
nnoremap gj j

nnoremap k gk
nnoremap gk k

" Set shell zsh
set shell=zsh

" Rebind exiting of in-built terminal emulator
tnoremap <Esc> <C-\><C-n>:bd!<CR>

" << Smart >> tab to autocomplete

function! Smart_TabComplete()
    let line = getline('.')

    let substr = strpart(line, -1, col('.')+1)


    let substr = matchstr(substr, "[^ \t]*$")
    if (strlen(substr)==0)
        return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1
    let has_slash = match(substr, '\/') != -1
    if (!has_period && !has_slash)
        return "\<C-X>\<C-P>"
    elseif ( has_slash )
        return "\<C-X>\<C-F>"
    else
        return "\<C-X>\<C-O>"
    endif
endfunction

" The actual binding for the above
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" Always show mode
set showmode

" Statusline Config
set laststatus=2
set statusline=

" Use white on dark gray
set statusline+=%1*

" File name
set statusline+=\ %t\ 

" Use black on light gray
set statusline+=%2*

" File type
set statusline+=\ 
set statusline+=%y

" Current Character Value [dec, hex]
set statusline+=\ [%b,\ %B]

" Lines
set statusline+=\ %LL

" Modified flag
set statusline+=\ 
set statusline+=%m

" Switch to right-hand side
set statusline+=%=

" Use white on black
set statusline+=%3*

" Cursor Position [row, col]
set statusline+=\ [%l,%c]

" Percentage through file
set statusline+=\ %p%%\ 

" Statusline colours

hi User1 ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
hi User2 ctermbg=lightgray ctermfg=black guibg=lightgray guifg=black
hi User3 ctermbg=black ctermfg=white guibg=black guifg=white
