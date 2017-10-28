" Max column limit
setlocal tw=79
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/

" Vim folding
set foldmethod=indent
