" PLUG: manage plugins {{{

" Reminder :
" + PlugUpdate
" + PlugClean (remove unused directories)
" + PlugUpgrade (upgrade vim-plug)

call plug#begin('~/.vim/plugged')

" Add support for async processes
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" For vim-markdown-composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
" }}}

" Language specific support {{{

" Check style and syntax
Plug 'scrooloose/syntastic'

if has('nvim')
  " Use asynchronous completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Enable included files completion
  Plug 'Shougo/neoinclude.vim'

  " Enable python jedi support
  Plug 'zchee/deoplete-jedi', { 'for' : 'python' }
endif

" Use super cool nvim asynchronous markdown preview
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

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

" Enable R support
Plug 'jalvesaq/Nvim-R', { 'for' : 'r' }

" }}}

" General functionnality {{{

" Use sensible vim defaults
Plug 'tpope/vim-sensible'

" Enable repeat for plugins
Plug 'tpope/vim-repeat'

" Display various info in lowerbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

" Taskwarrior is awesome
Plug 'blindFS/vim-taskwarrior'

" }}}

" Version control integration {{{

" Get awesome git support
Plug 'tpope/vim-fugitive'

" Display git lines status
Plug 'airblade/vim-gitgutter'

" }}}

" Text & code manipulation {{{

" Enable user to change, replace or delete surround (brackets, etc.)
Plug 'tpope/vim-surround'

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

" }}}

" Niceties {{{

" Use a pretty colorscheme ;-)
Plug 'chriskempson/base16-vim'

" }}}

" PLUG: THE END {{{

" Add plugins to &runtimepath
call plug#end()

" }}}
