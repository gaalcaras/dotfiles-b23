scriptencoding utf8

setlocal ignorecase " Case doesn't matter in notes
setlocal textwidth=79

map <Localleader>lv :call dotfiles#CompileMarkdown(1)<CR>
map <Localleader>ll :call dotfiles#CompileMarkdown(0)<CR>

augroup markdown
  autocmd BufWritePre * call dotfiles#LastModified("lastmodified")
augroup END

" Some useful completion when taking notes
inoremap <buffer> « ""<C-G>U<Left><Left>
inoremap <buffer> » "<C-G>U<Left><Left>

call dotfiles#UndoChunks()
