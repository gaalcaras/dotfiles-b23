scriptencoding utf8

setlocal ignorecase " Case doesn't matter in notes
setlocal textwidth=79

" ncm-2 compatibility
set completeopt-=longest

" DATE: {{{

iab <expr> ddate strftime("%c")

augroup Notes
  autocmd BufWritePre * call dotfiles#LastModified("Dernière modification")
  autocmd BufRead     * nested call dotfiles#DateCreated("Date de création")
  autocmd BufReadPost * call dotfiles#DateID()
augroup END

" }}}

" REMAPS: {{{

inoremap <c-g> <Esc>/<++><CR><Esc>cf>
noremap <c-g> <Esc>/<++><CR><Esc>cf>

noremap <c-i> :call dotfiles#InsertNoteHere()<cr>

" }}}

call dotfiles#UndoChunks()
