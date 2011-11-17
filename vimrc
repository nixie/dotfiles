" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
 
"syntax region Character start=/=====/ end=/=====/
syntax region Function start=/''/ end=/''/

"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

syntax on

:set listchars=tab:\|_,trail:.,eol:$
set fileencodings=utf-8,latin2,cp1250

filetype plugin indent on

set autowrite 
"tady je problem s backspacem
"imap <C-h> <Left> 
"imap <C-j> <Down> 
"imap <C-k> <Up> 
"imap <C-l> <Right>

" TVO settings
let maplocalleader = ","
"let g:otl_bold_headers = 0
let g:otl_text_view = 1
let g:otl_initial_foldlevel= 10

noremap <Space> <PageDown>
noremap <BS> <PageUp>

map _i i#include <ESC>a

map <A-1> :b1<CR> 
map <A-2> :b2<CR> 
map <A-3> :b3<CR> 
map <A-4> :b4<CR> 
map <A-5> :b5<CR> 
map <A-6> :b6<CR> 
map <A-7> :b7<CR> 
map <A-8> :b8<CR> 
map <A-9> :b9<CR> 
map <A-0> :b10<CR>
map <C-Tab> :bn<CR> 
map <S-C-Tab> :bp<CR> 
imap <A-1> <Esc>:b1<CR> 
imap <A-2> <Esc>:b2<CR> 
imap <A-3> <Esc>:b3<CR> 
imap <A-4> <Esc>:b4<CR> 
imap <A-5> <Esc>:b5<CR> 
imap <A-6> <Esc>:b6<CR> 
imap <A-7> <Esc>:b7<CR> 
imap <A-8> <Esc>:b8<CR> 
imap <A-9> <Esc>:b9<CR> 
imap <A-0> <Esc>:b10<CR> 
imap <C-Tab> <Esc>:bn<CR> 
imap <S-C-Tab> <Esc>:bp<CR>
set hlsearch

:nnoremap <F1> :bn<CR>
:nnoremap <F2> :bp<CR>
imap <F1> <Esc>:bn<CR>
imap <F2> <Esc>:bp<CR>

" ctags
map <F4> :TlistToggle<CR>


map <F5> :make<CR> 
imap <F5> <Esc>:make<CR>
map <F6> :make run<CR>
imap <F6> <Esc>:make<CR>
map <F7> :set list!<CR>
imap <F7> <Esc>:set list!<CR>

map <F9> gT
imap <F9> <Esc>gT
map <F12> gt
imap <F12> <Esc>gt


" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes) in terminals


set autoindent

" sizo of TAB
set tabstop=4
set sts=4   " when removing spaces in the begining of line, remove 4 (as it would
            " be TAB

" autoindent size of TAB
set shiftwidth=4
set expandtab

set wrap lbr
set showbreak=>

" real wrapping
"set textwidth=80

" po zalomení komentáře vlož na nový řádek znak komentáře
set formatoptions+=r

if has("statusline")
	set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

nnoremap <Leader>H yyp^v$r-o<Esc>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
	" hex mode should be considered a read-only operation
	" save values for modified and read-only for restoration later,
	" and clear the read-only flag for now
	let l:modified=&mod
	let l:oldreadonly=&readonly
	let &readonly=0
	let l:oldmodifiable=&modifiable
	let &modifiable=1
	if !exists("b:editHex") || !b:editHex
		" save old options
		let b:oldft=&ft
		let b:oldbin=&bin
		" set new options
		setlocal binary " make sure it overrides any textwidth, etc.
		let &ft="xxd"
		" set status
		let b:editHex=1
		" switch to hex editor
		%!xxd
	else
		" restore old options
		let &ft=b:oldft
		if !b:oldbin
			setlocal nobinary
		endif
		" set status
		let b:editHex=0
		" return to normal editing
		%!xxd -r
	endif
	" restore values for modified and read only state
	let &mod=l:modified
	let &readonly=l:oldreadonly
	let &modifiable=l:oldmodifiable
endfunction

" save and restore folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview


""start vim with colorscheme depending on daytime
"augroup starting		
"au  VimEnter * SetColors now
"augroup END


set fo+=t
"
"

" kernel tags:
"set tags=/home/collodi/src/tags


" MARTINEK-VUT
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set visualbell
"set backup

" so ~/.vim/config.vim - now sourced from after/ftplugin/c.vim
so ~/.vim/skeletons.vim


:set guifont=Terminus\ 10

if &term != "linux"
"set t_Co=256
:let g:zenburn_high_Contrast=1
:colors DevC++ " Set the colorscheme to zenburn
endif


au BufNewFile,BufRead *.t2t set ft=txt2tags
au BufNewFile,BufRead *.c set textwidth=80

"  VIMWIKI
" set directories
let g:vimwiki_list = [{'path': '~/.vimwiki/', 'path_html': '~/.vimwiki_html'},
         \ {'path': '~/.wiki-notes/', 'path_html': '~/.wiki-notes/html'}]

"GPG
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
    au!
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost    *.gpg   u
augroup END
