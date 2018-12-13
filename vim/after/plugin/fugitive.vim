" Fugitive
if ! exists('g:fugitive_git_executable')
  finish
endif

set diffopt+=vertical " Force vertical split event on small screens
let g:fugitive_git_executable = 'LANG=en_US git' " Force git english
