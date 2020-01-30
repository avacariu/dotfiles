" This is largely pieced together from a few different places.
" Code taken from https://github.com/chrisjohnson/vim8-bracketed-paste-mode-tmux/blob/master/plugin/vim8-bracketed-paste-tmux.vim
" Discussion: https://github.com/ConradIrwin/vim-bracketed-paste/issues/32


" NOTE: iTerm2 will show up as xterm-256color, and tmux shows up as
" screen-256color. We want to avoid using this on xterm because it leads to
" lag when hitting <ESC> (it takes about a second to get into NORMAL mode).
let s:screen = &term =~ 'screen'
let s:tmux = &term =~ 'tmux'

" make use of Xterm "bracketed paste mode"
" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
" http://stackoverflow.com/questions/5585129
if s:screen || s:tmux
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
endif
