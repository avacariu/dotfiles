function EnterPyrex()
    let g:bak_pymode_lint_checkers = g:pymode_lint_checkers
    let g:pymode_lint_checkers = []
endfunction

function ExitPyrex()
    let g:pymode_lint_checkers = g:bak_pymode_lint_checkers
endfunction

autocmd BufRead,BufEnter <buffer> call EnterPyrex()
autocmd BufLeave <buffer> call ExitPyrex()
