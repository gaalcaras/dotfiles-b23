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

setlocal ignorecase " Case doesn't matter in notes
setlocal textwidth=79

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
call dotfiles#ForceNonBreakingSpacePunctuation()

let g:vimtex_view_general_viewer = 'zathura'
