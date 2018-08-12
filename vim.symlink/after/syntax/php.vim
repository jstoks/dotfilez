set foldtext=PhpFoldText()

function! PhpFoldText()
    let line1 = getline(v:foldstart)
    let line2 = getline(v:foldstart + 1)
    return line1 . substitute( line2, '^\s*\(\s\|\*\)', '\1', '')
endfunction

