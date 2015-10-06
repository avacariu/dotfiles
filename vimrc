set nocompatible  " Needed for pathogen to work
call pathogen#infect()

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

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Ubuntu\ Mono\ 12
        set guioptions-=T   " toolbar
        set guioptions-=r   " right scrollbar

        " the powerline font is partially messed up in gvim
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        let g:airline_symbols.space = "\u3000"

        set lines=35 columns=85

    elseif has("gui_macvim")
        set guifont=Consolas:h12
    elseif has("gui_win32")
        set guifont=Consolas:h11
    endif
endif

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

" Spellcheck documents
autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell

let g:tex_flavor='latex'
let g:ycm_filetype_blacklist={'tex': 1}

if !has("gui_running")
    let g:CSApprox_loaded=1
    colorscheme wombat-term
else
    colorscheme wombat
endif

" set number of colors to 256 so CSApprox will work
let &t_Co=256

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
set wildignore=*.o,*~,*.pyc,*.class

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Incremental search
set incsearch

" Use <C-L> to clear highlighting of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
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
" Commented out because it conflicts with highlight.vim plugin
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" shortcut to cd to the current file's dir
" Might be nicer to make a cmap, though
" cmap cd %:h<CR>
command Cdh silent cd %:h

" Shortcut to clear search highlights
" Chosen because this is gedit's default
map <C-k> :nohls<CR>

" HTML indent levels because it seems that Vim will load ftplugin/html.vim
" even when ft=php
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2

" Use 79 columns as the limit for the width of text
" You can use `gq' to realign text.
set textwidth=79

" Disable automatic text wrapping
set formatoptions-=t

" set gundo to use F5
nnoremap <F5> :GundoToggle<CR>

let g:ycm_autoclose_preview_window_after_completion=1

" edit all buffers using current files (reload)
map <Leader>ge :windo e!<CR>

" switch buffers with Tab and S-Tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" allows hiding modified buffers (useful for using Tab to switch buffers)
set hidden

let g:airline_powerline_fonts = 1

nmap <Leader>e :NERDTreeToggle<CR>

nnoremap <Leader>q :q<CR>

" Use SS in visual mode to add spaces around selection
vmap SS s<Space><Space><Esc>P

" Disable YCM on some of my machines
if hostname() =~ '\(haimo\|do\|80x24\)'
    let g:loaded_youcompleteme = 1
endif

" highlight the current line
set cursorline

" use \s for spellcheck
nnoremap \s a<C-X><C-S>

" user CTRL-V to paste text while in insert mode
inoremap <C-V> <ESC>"+pa

" Don't add two spaces after . ? and !
set nojoinspaces

" Use the GNOME system clipboard when yanking and pasting
" NOTE: unnamed is X11, unnamedplus is GNOME
set clipboard^=unnamedplus
