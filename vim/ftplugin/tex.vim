" ABOLISH: abbreviations for LaTeX :)

Abolish git \gls{git}
Abolish patch{,s} \gls{,pl}{patch}
Abolish Linux \gls{linux}
Abolish vger \spacedlowsmallcaps{vger}
Abolish cvs \gls{cvs}
Abolish os{,s} \gls{,pl}{os}
Abolish uni{x,ces} \gls{,pl}{unix}
Abolish linuxkernel \gls{linuxkernel}
Abolish bsd \gls{bsd}
Abolish lkml \gls{lkml}
Abolish bitkeeper \gls{bitkeeper}
Abolish versioncontrol \gls{versioncontrol}

Abolish bd \textit{big data}

" Abolish '---' ~---

" Add quick delimiters for tex (since delimitmate and vim-latex are
" conflicting)
inoremap <buffer> ( ()<C-G>U<Left>
inoremap <buffer> [ []<C-G>U<Left>
inoremap <buffer> { {}<C-G>U<Left>
inoremap <buffer> " ""<C-G>U<Left>
inoremap <buffer> « «~~»<C-G>U<Left><Left>
inoremap <buffer> » ~»<C-G>U<Left><Left>

" Make small undo chunks for writing prose
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap : :<c-g>u
inoremap , ,<c-g>u
inoremap ; ;<c-g>u
