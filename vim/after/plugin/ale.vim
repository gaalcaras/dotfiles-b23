" ALE
if ! exists(':ALEFix')
  finish
endif

nmap <silent> <C-t> <Plug>(ale_previous_wrap)
nmap <silent> <C-s> <Plug>(ale_next_wrap)
nmap <silent> <leader>f <Plug>(ale_fix)

let g:ale_fixers = ['autopep8', 'yapf'] " Fix Python files
let g:ale_linters = {
      \'latex': ['chktex'],
      \}
