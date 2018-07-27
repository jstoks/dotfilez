
syn region pythonDocstring   start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend fold excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
hi link pythonDocString        Comment
set foldtext=getline(v:foldstart)
