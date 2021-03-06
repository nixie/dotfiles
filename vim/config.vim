set expandtab
"set guifont=-*-luxi\ mono-medium-r-normal-*-12-*-*-*-*-*-iso8859-2
"set guifont=Luxi\ Mono\ 12
"set helplang=cs
"set history=50
set hlsearch
set incsearch
set mouse=a
set ruler
set showcmd
"set termencoding=iso8859-2
"set number
"set lines=35
"set columns=88
"highlight Normal guibg=#fffff2
set smartindent
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l0,gs,hs,ps,t0,+s,c3,C0,(2s,us,U0,w0,m0,j0,)20,*30
imap ,if if ()<CR>{<CR>}<Esc>2k$i
imap ,ie if ()<CR>{<CR>}<CR>else<CR>{<CR>}<Esc>5k$i
imap ,fo for (;;)<CR>{<CR>}<Esc>2k$F;F;i
imap ,fi for (int i = 0; i < ; i++)<CR>{<CR>}<Esc>2k$F;i
imap ,wh while ()<CR>{<CR>}<Esc>2k$i
imap ,do do<CR>{<CR>} while();<Esc>hi
imap ,sw switch ()<CR>{<CR>}<Esc>2k$i
imap ,ca case 0:<CR>break;<Esc>k$F0xi
imap ,de default :<CR>break;<Esc>k$a
imap ,pr printf("\n");<Esc>F\i
