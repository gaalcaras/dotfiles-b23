" NCM: autocompletion {{{
au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'vimtex',
            \ 'priority': 1,
            \ 'subscope_enable': 1,
            \ 'complete_length': 1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \           'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \               {'name': 'prefix', 'key': 'word'},
            \           ]},
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
" }}}
" ABOLISH: abbreviations for LaTeX :)

if exists("g:loaded_abolish")
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
endif

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
