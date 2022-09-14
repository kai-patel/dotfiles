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
"set shell=zsh

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
"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" Turn off errorbell for Esc in Normal mode
set belloff=esc

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


" PLUGINS
" -------

" Install vim-plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'ervandew/supertab' " Don't use with coc (messes up TAB to complete)
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'pantharshit00/vim-prisma'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'
call plug#end()

" ALE Config
let g:ale_linters = {'rust': ['analyzer'], 'typescriptreact': ['eslint', 'prettier']}
let g:ale_echo_msg_format = '%linter% -- %s'
let g:ale_fixers = {'typescriptreact': ['prettier'], 'python': ['black']}

nnoremap <S-A-F> :ALEFix<CR>

" Coc Config
set updatetime=300 " Default 4000 (ms)
set signcolumn=yes
let g:coc_global_extensions = ['coc-rust-analyzer', '@yaegassy/coc-tailwindcss3', 'coc-tsserver', 'coc-clangd', 'coc-prisma']

" Redefine <TAB> for coc autocompletion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" NERDTree Config
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

" Toggle NERDTree
nnoremap <silent> <C-_> :NERDTreeToggle<CR>
