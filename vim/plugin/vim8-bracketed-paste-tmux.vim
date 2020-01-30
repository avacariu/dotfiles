" This is largely pieced together from a few different places:
" - https://github.com/chrisjohnson/vim8-bracketed-paste-mode-tmux/blob/master/plugin/vim8-bracketed-paste-tmux.vim
" - https://github.com/ConradIrwin/vim-bracketed-paste/issues/32
" - http://stackoverflow.com/questions/5585129
"
" Some changes have been from the above sources to make it more reliable:
" - ensure <f28> and <f29> are used instead of \<ESC> prefixes because
"   otherwise Vim will wait for the rest of the characters when you try to hit
"   ESC to get out of insert mode.
" - don't set pastetoggle to <f29> or else it won't trigger.
" - pastetoggle can use the \<ESC> prefix without a lag, because the lag only
"   shows up in a mapping

if exists("g:loaded_bracketed_paste")
  finish
endif

let g:loaded_bracketed_paste = 1


" make use of Xterm "bracketed paste mode"
" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
function! s:BeginXTermPaste(ret)
  set paste
  return a:ret
endfunction

" enable bracketed paste mode on entering Vim
let &t_ti .= "\e[?2004h"

" disable bracketed paste mode on leaving Vim
let &t_te = "\e[?2004l" . &t_te

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"

" XXX: this pastetoggle can't be <f29> or else it won't get triggered!
set pastetoggle=\<ESC>[201~

inoremap <expr> <f28> <SID>BeginXTermPaste("")
nnoremap <expr> <f28> <SID>BeginXTermPaste("i")
vnoremap <expr> <f28> <SID>BeginXTermPaste("c")
cnoremap <f28> <nop>
cnoremap <f29> <nop>
