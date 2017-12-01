scriptencoding utf8

setlocal ignorecase " Case doesn't matter in notes
setlocal textwidth=79

" DATE: {{{

iab <expr> ddate strftime("%c")

augroup Notes
  autocmd BufWritePre * call dotfiles#LastModified("Dernière modification")
  autocmd BufRead     * nested call dotfiles#DateCreated("Date de création")
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

call dotfiles#UndoChunks()
