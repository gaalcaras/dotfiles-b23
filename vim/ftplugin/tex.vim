" NCM: autocompletion {{{
augroup my_cm_setup
    autocmd!
    autocmd User CmSetup call cm#register_source({
          \ 'name' : 'vimtex',
          \ 'priority': 8,
          \ 'scoping': 1,
          \ 'scopes': ['tex'],
          \ 'abbreviation': 'tex',
          \ 'cm_refresh_patterns': g:vimtex#re#ncm,
          \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
          \ })
augroup END
" }}}
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

" Add quick delimiters for tex (since delimitmate and vim-latex are
" conflicting)
inoremap <buffer> ( ()<C-G>U<Left>
inoremap <buffer> [ []<C-G>U<Left>
inoremap <buffer> { {}<C-G>U<Left>
inoremap <buffer> " ``''<C-G>U<Left><Left>
inoremap <buffer> « «~~»<C-G>U<Left><Left>
inoremap <buffer> » ~»<C-G>U<Left><Left>

" Make small undo chunks for writing prose
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap : :<c-g>u
inoremap , ,<c-g>u
inoremap ; ;<c-g>u

" Custom vim-sandwich for tex files: «~|~»
let french_quotes = [
      \ {'__filetype__': 'tex', 'buns': ['«~', '~»'], 'nesting': 1, 'input': [ '«' ], 'filetype': ['initex', 'plaintex', 'tex']}
      \ ]

if !exists('s:local_recipes')
  let s:local_recipes = french_quotes
else
  let s:local_recipes += french_quotes
endif

call sandwich#util#addlocal(s:local_recipes)
