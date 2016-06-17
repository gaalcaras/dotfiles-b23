" ABOLISH: abbreviations for LaTeX :)

Abolish git \gls{git}
Abolish test testtest
Abolish correcti{f,fs} \gls{,pl}\{patch\}
Abolish Linux \gls{linux}

" Add quick delimiters for tex (since delimitmate and vim-latex are
" conflicting)
inoremap <buffer> ( ()<C-G>U<Left>
inoremap <buffer> [ []<C-G>U<Left>
inoremap <buffer> { {}<C-G>U<Left>
inoremap <buffer> " ""<C-G>U<Left>
inoremap <buffer> « «~~»<C-G>U<Left><Left>

" Hide 80 char limit
set colorcolumn=0
