scriptencoding utf8

setlocal ignorecase " Case doesn't matter in notes
setlocal textwidth=79

map <Localleader>lv :call dotfiles#CompileMarkdown(1)<CR>
map <Localleader>ll :call dotfiles#CompileMarkdown(0)<CR>

augroup markdown
  autocmd BufWritePre * call dotfiles#LastModified("lastmodified")
  " Open all folds when opening
  autocmd BufEnter * normal zR
augroup END

" Some useful completion when taking notes
inoremap <buffer> « ""<C-G>U<Left><Left>
inoremap <buffer> » "<C-G>U<Left><Left>

call dotfiles#UndoChunks()
call dotfiles#ForceNonBreakingSpacePunctuation()

" Markdown composer settings
let g:markdown_composer_browser="firefox --new-window"
let g:markdown_composer_autostart=0
