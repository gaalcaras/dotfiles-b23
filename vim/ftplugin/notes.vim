" Case doesn't matter in notes
scriptencoding utf8

setlocal ignorecase
setlocal textwidth=79

" DATE: {{{

iab <expr> ddate strftime("%c")

augroup Notes
  autocmd BufWritePre * call   dotfiles#LastModified()
  autocmd BufRead     * nested call dotfiles#DateCreated()
  autocmd BufReadPost * call   dotfiles#DateID()
augroup END

" }}}

" REMAPS: {{{

inoremap <c-g> <Esc>/<++><CR><Esc>cf>
noremap <c-g> <Esc>/<++><CR><Esc>cf>

" Some useful completion when taking notes
inoremap <buffer> ( ()<C-G>U<Left>
inoremap <buffer> [ []<C-G>U<Left>
inoremap <buffer> { {}<C-G>U<Left>
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
