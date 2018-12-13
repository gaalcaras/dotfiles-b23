" Denite
if ! exists('g:loaded_denite')
  finish
endif

call denite#custom#source('file_rec', 'matchers',
      \ ['matcher_fuzzy', 'matcher_ignore_globs'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/', '.pytest_cache/',
      \   '*.png', '*.pdf', '*.jpg', '*.aux', '*.out',
      \   '.Rproj.user/*', '.~lock*', '.Rhistory',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
