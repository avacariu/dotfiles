" Plugins {{{
" This needs to be at the top to ensure the ftplugin loads before the syntax
" rules (which is necessary for vim-ledger).
filetype plugin indent on

set nocompatible  " Needed for pathogen to work

runtime pack/plugin-bundle/start/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

let g:ale_linters = {'python': ['jedils', 'pylint']}
let g:ale_fixers = {'python': ['isort']}
let g:ale_floating_preview = 1
let g:ale_virtualtext_cursor = 0
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

" Wrappers are used because I don't want to have to specify dependencies like
" jedils and isort in the pyproject.toml, but I still want to ensure that the
" pyproject.toml (and .python-version) is considered when deciding the Python
" version. This is important when writing code that might be a syntax error in
" older versions of Python.
" NOTE: you can 'let g:ale_use_global_executables = 1' in general, but I don't
" know if I want that yet.
" NOTE: It's important not to set g:ale_python_auto_uv = 1, because that
" overrides these executables.
let g:ale_python_auto_uv = 0
let g:ale_python_jedils_executable = $HOME . '/.local/bin/ale/ale-jedils'
let g:ale_python_jedils_use_global = 1
let g:ale_python_pylint_executable = $HOME . '/.local/bin/ale/ale-pylint'
let g:ale_python_pylint_use_global = 1
let g:ale_python_isort_executable = $HOME . '/.local/bin/ale/ale-isort'
let g:ale_python_isort_use_global = 1

nmap <leader>gd :ALEGoToDefinition<CR>
nmap <leader>gr :ALEFindReferences<CR>
nmap <leader>n :lnext<CR>
nmap <leader>N :lprev<CR>
nmap <leader>is :ALEFix isort<CR>
autocmd Filetype python nmap K :ALEHover<CR>

" NOTE: <S-Down> and <S-Up> are netrw bindings
nnoremap <silent> <S-Left> :bprevious<CR>
nnoremap <silent> <S-Right> :bnext<CR>

" autoclose preview window (the place the help text is shown when
" autocompleting python methods)
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='wombat'

let g:showmarks_enable=0

let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }

let g:ctrlp_working_path_mode = 'r'

nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

let g:tex_flavor = 'latex'

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
" Kitty FAQ Settings {{{
" I think only bracketed paste is really necessary, though. The FAQ entry
" references some github issue discussions from 2022 and it seems some things
" have improved since then (even if the github issues are still open). These
" settings are going to be terminal-specific, so this should be the first place
" to check if a terminal doesn't work right. They seem to work fine with kitty,
" alacritty, and tmux.

" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"

" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''
" }}}
" Colours {{{
" These have to come after the kitty FAQ settings
colorscheme wombat

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

" credit https://n8henrie.com/2021/05/copy-and-paste-between-vim-selection-and-tmux/
vnoremap <leader>tc y<cr>:call system("tmux load-buffer -", @0)<cr>gv
nnoremap <leader>tp :let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;

" Use mouse for scrolling
set mouse=a

" TODO: is this still true after the kitty FAQ settings set above?
" NOTE: It's important to use the tmux-focus-events.vim plugin for this because
" even though Vim supports these events by default they seem to only work if
" you set term=xterm which I don't want to do (it breaks colors).
autocmd FocusGained * set mouse+=a
autocmd FocusLost * set mouse=

" This is required because the default ttymouse is xterm when running under
" tmux. We need to override this so that using the mouse to drag windows works
" under tmux.
set ttymouse=sgr

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
nnoremap <expr> <leader>gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Keep selected text when changing indentation
vnoremap < <gv
vnoremap > >gv

set smoothscroll
" }}}
" Search {{{
set incsearch
set hlsearch

" These say "ignore case unless something is capitalized. Use \c or \C to
" override this.
set ignorecase
set smartcase
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
