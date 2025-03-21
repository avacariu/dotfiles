" Plugins {{{
" This needs to be at the top to ensure the ftplugin loads before the syntax
" rules (which is necessary for vim-ledger).
filetype plugin indent on

set nocompatible  " Needed for pathogen to work

runtime pack/plugin-bundle/start/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

let g:ale_python_auto_uv = 1
let g:ale_linters = {'python': ['jedils', 'pylint']}
let g:ale_floating_preview = 1
let g:ale_virtualtext_cursor = 0
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

nmap <leader>gd :ALEGoToDefinition<CR>
nmap <leader>gr :ALEFindReferences<CR>
autocmd Filetype python nmap K :ALEHover<CR>

" autoclose preview window (the place the help text is shown when
" autocompleting python methods)
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='wombat'

let g:showmarks_enable=0

let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }

" This searches Files, Buffers and MRU files at the same time. For whatever
" reason, regular CtrlP mode will miss a lot of files in the root directory
" (e.g. Makefiles). Searching MRU files seems to work a lot better than regular
" file searching.
let g:ctrlp_cmd = 'CtrlPMixed'

let g:tex_flavor='latex'

let g:netrw_altfile = 1

" this ensures the netrw buffer gets closed when you open a file from it
" See: https://github.com/tpope/vim-vinegar/issues/13
let g:netrw_fastbrowse = 0
" }}}
" Spaces & Tabs {{{
" Use spaces instead of tabs
set expandtab
set shiftwidth=4  " Used when indenting with << or >>
set tabstop=4     " How many columns a tab counts for
set softtabstop=4 " How many columns vim uses when you hit tab in insert mode.
" }}}
" UI {{{
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

" this is because there seems to be problems in tmux with the background not
" being completely painted.
" See https://vi.stackexchange.com/questions/238/tmux-is-changing-part-of-the-background-in-vim
if &term =~ '256color'
  " disable Background Color Erase (BCE)
  set t_ut=
endif
" }}}
" Maps and Movement {{{

" Use w!! to write as root (when you forgot to sudo vim filename)
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Shortcut to clear search highlights
nmap <silent> <BS>  :nohlsearch<CR>

" Let j/k behave like other editors (if a line is split, don't skip
" to the next line)
" Only have it work in normal mode!
nmap j gj
nmap k gk

" set gundo to use F5
nnoremap <leader>u :UndotreeToggle<CR>

" edit all buffers using current files (reload)
map <Leader>ge :windo e!<CR>

" switch buffers with Tab and S-Tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap <Leader>q :q<CR>

nnoremap <leader>w :w<CR>

nnoremap <silent> <leader>o :call append(line('.'), '')<CR>
nnoremap <silent> <leader>O :call append(line('.') - 1, '')<CR>

" Use SS in visual mode to add spaces around selection
vnoremap <silent> SS :<C-U>call AddSpacesAround()<CR>
function! AddSpacesAround() range
    let m = visualmode()
    if m ==# 'v' || m ==# "\<C-V>"
        execute "normal gvs\<space>\<space>\<esc>P"
    elseif m ==# 'V'
        call append(line("'<")-1, '')
        call append(line("'>"), '')
    endif
endfunction

" use \s for spellcheck
nnoremap \s a<C-X><C-S>

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

" Use ctrl-{hjkl} to switch panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use up/down/left/right in Visual moe to move text around
vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight

" `gp' will select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Keep selected text when changing indentation
vnoremap < <gv
vnoremap > >gv
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

" macOS has('unix') but Linux doesn't has('macunix') so this is the simplest
" way of handling the check
if !has('macunix')
    " Use the GNOME system clipboard when yanking and pasting
    " NOTE: unnamed is X11, unnamedplus is GNOME
    set clipboard^=unnamedplus
endif

" allows hiding modified buffers (useful for using Tab to switch buffers)
set hidden

set nopaste
set confirm
set modelines=1

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Save swap file every 10 characters types
set updatecount=10

" Don't auto-insert completion options, and show a menu even if there's only
" one item
set completeopt=menuone,noinsert
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

set pastetoggle=<leader>p

function RandomLine()
    :py3 import vim, random;
        \ vim.current.window.cursor = (random.randint(1, len(vim.current.buffer)+1), 0)
endfunction
"}}}
" vim:foldmethod=marker:foldlevel=0
