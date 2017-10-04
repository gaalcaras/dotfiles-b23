" Case doesn't matter in notes
setlocal ignorecase
setlocal tw=79

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

" Make small undo chunks for writing prose
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap : :<c-g>u
inoremap , ,<c-g>u
inoremap ; ;<c-g>u
