setlocal tw=79
setlocal fo+=t

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/
