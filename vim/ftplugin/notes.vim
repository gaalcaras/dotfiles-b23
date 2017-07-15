" DATE: {{{

iab <expr> ddate strftime("%c")

" }}}

" ABOLISH: {{{


" }}}

" REMAPS: {{{

" Add quick delimiters for tex (since delimitmate and vim-latex are
" conflicting)
inoremap <buffer> ( ()<C-G>U<Left>
inoremap <buffer> [ []<C-G>U<Left>
inoremap <buffer> { {}<C-G>U<Left>
inoremap <buffer> " ""<C-G>U<Left>
inoremap <buffer> « «~~»<C-G>U<Left><Left>

" }}}
