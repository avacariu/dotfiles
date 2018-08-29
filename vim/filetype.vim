if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    " VHDL files created by DesignWorks
    au! BufNewFile,BufRead *.dwv                     setf vhdl
    au! BufNewFile,BufRead *.gradle                  setf groovy
    au! BufNewFile,BufRead *.md                      setf markdown
    au! BufNewFile,BufRead *.twg                     setf htmldjango
    au! BufNewFile,BufRead .tmux.conf*,tmux.conf*    setf tmux
    au! BufNewFile,BufRead Pipfile                   setf toml
    au! BufNewFile,BufRead Pipfile.lock              setf json
augroup END
