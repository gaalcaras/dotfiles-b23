" ###########################
" VARIOUS: personal settings
" ###########################

" Set comma as leader
let mapleader = ","

" Display number of current line
set number

" Enable syntax highlighting
syntax on

" Force markdown recognition
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Hit Control+g to "getaway" from parenthesis
inoremap <C-g> <Esc>/[)}*"»'`\]*]<CR>:nohl<CR>a

" Disable mouse visual mode
set mouse-=a

" Have sane text files
set fileformat=unix

" The idea here is to allow wrapping, mainly for text editing.
set wrap
set linebreak

" Disable list (otherwise, breaks linebreak)
set nolist 

set textwidth=0
set wrapmargin=0
set formatoptions=qrn1
silent! set breakindent showbreak=..

" But when coding, we will want to see the 80 character limit as a reminder
" of good practices.
set colorcolumn=80

" Show cursor at all times
set ruler

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set foldmethod=indent

" Open all folds on document load
set foldlevelstart=9

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Indent sanely
set autoindent
set smartindent

" Never use arrow keys ;-)
nnoremap <Left> :echoe "Use c"<CR>
nnoremap <Right> :echoe "Use r"<CR>
nnoremap <Up> :echoe "Use s"<CR>
nnoremap <Down> :echoe "Use t"<CR>

" Get rid of additionnal files
set nobackup
set nowritebackup
set noswapfile

" Prefer a slightly higher line height
set linespace=3

" Hide mouse when typing
set mousehide

" French Spelling
setlocal spell spelllang=fr
