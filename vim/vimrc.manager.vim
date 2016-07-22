" ###########################
" PLUG: manage plugins
" ###########################

" Reminder : PlugUpdate, PlugClean

call plug#begin('~/.vim/plugged')

" Add support for async processes
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

" ////////////////////////////
" Language specific support
" ////////////////////////////

" Check style and syntax
Plug 'scrooloose/syntastic'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" Add completion for NEOVIM
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote'), 'for' : ['javascript', 'typescript', 'c', 'python', 'html', 'latex', 'tex', 'bash', 'shell', 'r'] }

  " Add ternjs support to Deoplete
  Plug 'carlitux/deoplete-ternjs', { 'for' : ['javascript', 'es6'] }
endif

" Add support for TS autocompletion
Plug 'Quramy/tsuquyomi', { 'for' : ['javascript', 'typescript'] }

" Add support for TS syntax colorscheme
Plug 'leafgarland/typescript-vim', { 'for' : 'typescript' }

" Improve javascript indentation and syntax support
Plug 'pangloss/vim-javascript', { 'for' : ['javascript', 'typescript', 'es6'] }

" Add latex support
Plug 'lervag/vimtex', { 'for' : ['latex', 'tex'] }

" Enable markdown support
Plug 'plasticboy/vim-markdown', { 'for' : 'markdown' }

" Enable markdown toc generation
Plug 'mzlogin/vim-markdown-toc', { 'for' : 'markdown' }

" Enable markdown live preview
" Do install steps : https://github.com/suan/vim-instant-markdown
Plug 'suan/vim-instant-markdown', { 'for' : 'markdown' }

" Enable R support
Plug 'jalvesaq/Nvim-R', { 'for' : 'r' }

" ////////////////////////////
" General functionnality
" ////////////////////////////

" Use sensible vim defaults
Plug 'tpope/vim-sensible'

" Get fuzzy file search
Plug 'Shougo/unite.vim'

" Display various info in lowerbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Add tmuxline support
Plug 'edkolev/tmuxline.vim'

" Create templates when opening new file
Plug 'aperezdc/vim-template'

" ////////////////////////////
" Version control integration
" ////////////////////////////

" Get awesome git support
Plug 'tpope/vim-fugitive'

" Display git lines status
Plug 'airblade/vim-gitgutter'

" ////////////////////////////
" Text & code manipulation
" ////////////////////////////

" Enable user to change, replace or delete surround (brackets, etc.)
Plug 'tpope/vim-surround'

" Add mappings
Plug 'tpope/vim-unimpaired'

" Automatically set 'set:paste' in insert mode
Plug 'ConradIrwin/vim-bracketed-paste'

" Enable toggling comment
Plug 'tomtom/tcomment_vim'

" Handle delimiters automatically
Plug 'raimondi/delimitmate'

" Add text alignment capabilities to vim
Plug 'godlygeek/tabular'

" Add support for abbreviations
Plug 'tpope/vim-abolish'

" ////////////////////////////
" Niceties
" ////////////////////////////

" Use a pretty colorscheme ;-)
Plug 'altercation/vim-colors-solarized'

" ////////////////////////////
" THE END
" ////////////////////////////

" Add plugins to &runtimepath
call plug#end()
