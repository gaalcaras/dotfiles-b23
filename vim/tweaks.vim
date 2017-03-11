" MAPPINGS: personal tweaks {{{

" Set comma as leader
let mapleader = ","

" Hit Control+g to "getaway" from parenthesis
inoremap <C-g> <Esc>/[)}*"»'`\]*]<CR>:nohl<CR>a

" Easier tag navigation
nnoremap <C-m> <C-]>
vnoremap <C-m> <C-]>

" Open file under cursor in vertical split
nnoremap g<CR> <C-w>vgf

" Open file under cursor in horizontal split
nnoremap g<SPACE> <C-w>f

" Easier pipe operator in R: '>'
autocmd FileType r inoremap <buffer> > <Esc>:normal! a%>%<CR>a<CR>
autocmd FileType rnoweb inoremap <buffer> > <Esc>:normal! a%>%<CR>a<CR>
autocmd FileType rmd inoremap <buffer> > <Esc>:normal! a%>%<CR>a<CR>

" }}}

" HARDMODE: well, kind of {{{

" Never use arrow keys ;-)
nnoremap <Left> :echoe "Use c ;-)"<CR>
nnoremap <Right> :echoe "Use r ;-)"<CR>
nnoremap <Up> :echoe "Use s ;-)"<CR>
nnoremap <Down> :echoe "Use t ;-)"<CR>

inoremap <Left> <Esc>:echoe "Use c ;-)"<CR>
inoremap <Right> <Esc>:echoe "Use r ;-)"<CR>
inoremap <Up> <Esc>:echoe "Use s ;-)"<CR>
inoremap <Down> <Esc>:echoe "Use t ;-)"<CR>

vnoremap <Left> :echoe "Use c ;-)"<CR>
vnoremap <Right> :echoe "Use r ;-)"<CR>
vnoremap <Up> :echoe "Use s ;-)"<CR>
vnoremap <Down> :echoe "Use t ;-)"<CR>

" Say goodbye to backspace and delete in Insert mode
inoremap <BS> <Nop>
inoremap <Del> <Nop>

" }}}

" FILE_BROWSING: it's better {{{

" Make file search recursive in dirs and subdirs
set path+=**

" disable annoying banner
let g:netrw_banner=0
" open in prior window
let g:netrw_browse_split=4
" open splits to the right
let g:netrw_altv=1
" tree view
let g:netrw_liststyle=3 
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" }}}

" MISC: all the small things {{{

" Enable syntax highlighting
syntax on

" Disable mouse visual mode
set mouse-=a

" Have sane text files
set fileformat=unix

" Folding with brackets
set foldmethod=marker

" The idea here is to allow wrapping, mainly for text editing.
set wrap
set linebreak

" Disable list (otherwise, breaks linebreak)
set nolist
set textwidth=0
set wrapmargin=0
set formatoptions=qrn1
silent! set breakindent showbreak=..

" Show cursor at all times
set ruler

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Indent sanely
set smartindent

" Relative numbers
set relativenumber
set number

" Get rid of additionnal files
set nobackup
set nowritebackup
set noswapfile

" Prefer a slightly higher line height
set linespace=3

" Hide mouse when typing
set mousehide

" Enable both French and English spell check
setlocal spell spelllang=fr,en

" Underline spell check results
hi clear SpellBad
hi SpellBad cterm=underline

" Sorry ExMode, but you've gotta go
map q: <Nop>
nnoremap Q <nop>

" }}}
