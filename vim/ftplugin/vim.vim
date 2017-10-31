" Max column limit
setlocal textwidth=79
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/

" Vim folding
setlocal foldmethod=indent
setlocal foldlevelstart=0

" Keybinding for visiting the GitHub page of the plugin defined on the current
" line.
nnoremap <silent> gp :call dotfiles#OpenPluginHomepage()<CR>
