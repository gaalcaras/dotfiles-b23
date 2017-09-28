" Case doesn't matter in notes
set ignorecase

" DATE: {{{

iab <expr> ddate strftime("%c")

source $HOME/.dotfiles/vim/functions.vim
autocmd BufWritePre * call LastModified()
autocmd BufRead * nested call DateCreated()
autocmd BufReadPost * call DateID()

" }}}

" REMAPS: {{{

inoremap <c-g> <Esc>/<++><CR><Esc>cf>
noremap <c-g> <Esc>/<++><CR><Esc>cf>

" Some useful completion when taking notes
inoremap <buffer> ( ()<C-G>U<Left>
inoremap <buffer> [ []<C-G>U<Left>
inoremap <buffer> { {}<C-G>U<Left>
inoremap <buffer> ' ''<C-G>U<Left><Left>
inoremap <buffer> " ""<C-G>U<Left><Left>
inoremap <buffer> « ""<C-G>U<Left><Left>
inoremap <buffer> » "<C-G>U<Left><Left>

" }}}
