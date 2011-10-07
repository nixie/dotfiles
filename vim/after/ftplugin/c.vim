" Highlighting of lines longer than 80 chars
hi LineTooLong cterm=bold ctermbg=red guibg=red
match LineTooLong /\%>80v.\+/
autocmd BufWinEnter,Syntax * exe "match LineTooLong /\\%>80v.\\+/"

so ~/.vim/config.vim
