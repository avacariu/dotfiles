set nopaste

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4  " Used when indenting with << or >>
set tabstop=4     " How many columns a tab counts for
set softtabstop=4 " How many columns vim uses when you 
                  " hit tab in insert mode.

set wildmenu

" Highlight all search results
set hlsearch

if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 12
elseif has("gui_macvim")
    set guifont=Consolas:h12
elseif has("gui_win32")
    set guifont=Consolas:h11
end

set nu

" Show the current position
set ruler

set colorcolumn=80

syntax enable

if has("autocmd")
    filetype plugin indent on
else
    set cindent
endif

" VHDL files created by DesignWorks
autocmd BufRead,BufNewFile *.dwv set filetype=vhdl

colorscheme wombat

let &t_Co=256

set bs=2
set backspace=indent,eol,start

set confirm
set showcmd

let g:showmarks_enable=0

imap jj <Esc>

" Use w!! to write as root (when you forgot to sudo vim filename)
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Set how many lines of history VIM has to remember
set history=500

" Set 5 lines to the cursor - when moving vertically using j/k
set so=3

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Incremental search
set incsearch

" Use <C-L> to clear highlighting of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Allow color schemes do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^linux'
    set t_Co=16
endif

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Show as much of a really long line as possible instead of @
set display+=lastline

" Always show the status line
set laststatus=2

" Let j/k behave like other editors (if a line is split, don't skip
" to the next line)
" Only have it work in normal mode!
nmap j gj
nmap k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
