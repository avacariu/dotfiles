" Plugins {{{
set nocompatible  " Needed for pathogen to work
call pathogen#infect()
call pathogen#helptags()
let g:pymode_rope = 0
let g:pymode_python = 'python3'

" Ignore 'line too long' messages. I can't always make the line shorter, and it
" distracts from other messages. Plus, I already use colorcolumn.
let g:pymode_lint_ignore = "E501,C901"

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:showmarks_enable=0

let g:ctrlp_user_command = 'find %s -type f'

" This searches Files, Buffers and MRU files at the same time. For whatever
" reason, regular CtrlP mode will miss a lot of files in the root directory
" (e.g. Makefiles). Searching MRU files seems to work a lot better than regular
" file searching.
let g:ctrlp_cmd = 'CtrlPMixed'

let g:gundo_prefer_python3 = 1

let g:tex_flavor='latex'
let g:ycm_filetype_blacklist={'tex': 1}
let g:ycm_autoclose_preview_window_after_completion=1

" Disable YCM on some of my machines
if hostname() =~ '\(haimo\|do\|80x24\|cs-nll-21\)'
    let g:loaded_youcompleteme = 1
endif
" }}}
" Spaces & Tabs {{{
" Use spaces instead of tabs
set expandtab
set shiftwidth=4  " Used when indenting with << or >>
set tabstop=4     " How many columns a tab counts for
set softtabstop=4 " How many columns vim uses when you hit tab in insert mode.
" }}}
" UI {{{
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

" Send more characters to the screen for redrawing, instead of using
" insert/delete line commands
set ttyfast

" If there are more than 3 lines to scroll, redraw the screen. Good for when
" redrawing is fast, but scrolling is slow in a terminal.
set ttyscroll=3

" Don't redraw the screen when executing macros, registers and other commands
" that have not been typed.
set lazyredraw

" Show < and > when the line continues offscreen.
" NOTE: precedes only seems to work when `list` is set, but I'm not sure if I
" want to do that.
set listchars=extends:>,precedes:<

set cursorline
" }}}
" Layout {{{
set ruler    " Show the current position
set number
set colorcolumn=80

set wildmenu

" Set 3 lines to the cursor - when moving vertically using j/k
set scrolloff=3

" Leave 5 column on each side of the cursor when moving horizontally
set sidescrolloff=5

" Show as much of a really long line as possible instead of @
set display+=lastline

" Always show the status line
set laststatus=2

" Use 79 columns as the limit for the width of text
" You can use `gq' to realign text.
set textwidth=79

" Auto-wrap comments and allow formatting of comments with "gq"
set formatoptions=cqlj

set showcmd
" }}}
" Colours {{{
colorscheme wombat
" }}}
" Maps and Movement {{{
imap jj <Esc>

" Use w!! to write as root (when you forgot to sudo vim filename)
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Shortcut to clear search highlights
" Chosen because this is gedit's default
map <C-k> :nohls<CR>

" Make Y consistent with C and D. See :help Y.
nnoremap Y y$

" Let j/k behave like other editors (if a line is split, don't skip
" to the next line)
" Only have it work in normal mode!
nmap j gj
nmap k gk

" set gundo to use F5
nnoremap <leader>u :GundoToggle<CR>

" edit all buffers using current files (reload)
map <Leader>ge :windo e!<CR>

" switch buffers with Tab and S-Tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nmap <Leader>e :NERDTreeToggle<CR>

nnoremap <Leader>q :q<CR>

nnoremap <leader>w :w<CR>

" Use SS in visual mode to add spaces around selection
vmap SS s<Space><Space><Esc>P

" use \s for spellcheck
nnoremap \s a<C-X><C-S>

" user CTRL-V to paste text while in insert mode
inoremap <C-V> <ESC>"+pa

" Use mouse for scrolling
set mouse=a
nmap <LeftMouse> <nop>
imap <LeftMouse> <nop>
vmap <LeftMouse> <nop>

" Center the search result
map N Nzz
map n nzz

" Scroll horizontally by 1 column at a time (default is 0 which means to center
" the cursor when moving past the edge of the screen)
set sidescroll=1
" }}}
" Search {{{
set incsearch
set ignorecase
set smartcase
set hlsearch
" }}}
" Syntax & Indent {{{
syntax enable

set autoindent
filetype plugin indent on

" Don't highlight syntax past this column
set synmaxcol=196

set backspace=indent,eol,start

function Reindent2to4() range
    setlocal tabstop=2 softtabstop=2 noexpandtab
    execute (a:firstline + 1) . "," . a:lastline . 'retab!'
    setlocal tabstop=4 softtabstop=4 expandtab
    execute (a:firstline + 1) . "," . a:lastline . 'retab'
endfunction

command -range=% Reident2to4 <line1>,<line2>call Reindent2to4()
" }}}
" Behaviour {{{
" Set how many lines of history VIM has to remember
set history=500

" Don't add two spaces after . ? and !
set nojoinspaces

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class

" Use the GNOME system clipboard when yanking and pasting
" NOTE: unnamed is X11, unnamedplus is GNOME
set clipboard^=unnamedplus

" allows hiding modified buffers (useful for using Tab to switch buffers)
set hidden

set nopaste
set confirm
set modelines=1

" Use Unix as the standard file type
set ffs=unix,dos,mac
" }}}
" Misc {{{
" shortcut to cd to the current file's dir
" Might be nicer to make a cmap, though
" cmap cd %:h<CR>
command Cdh silent cd %:h

" HTML indent levels because it seems that Vim will load ftplugin/html.vim
" even when ft=php
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2

" Don't fold the top level; only fold stuff below (e.g. don't fold classes, but
" fold methods within classes)
set foldlevel=1
"}}}
" vim:foldmethod=marker:foldlevel=0
