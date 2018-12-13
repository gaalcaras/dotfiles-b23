" vimtex
if ! exists(':VimtexInfo')
  finish
endif

let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_latexlog = {'fix_paths':0}

augroup vimtex_config
  autocmd!
  autocmd User VimtexEventQuit     VimtexClean " Clean aux files after quitting
  autocmd User VimtexEventInitPost VimtexCompile " Open pdf when opening
augroup END

" Remap these to avoid conflict with BÉPO mapping (t -> è)
nnoremap èsD <Plug>(vimtex-delim-toggle-modifier-reverse)
nnoremap èsd <Plug>(vimtex-delim-toggle-modifier)
nnoremap èsc <Plug>(vimtex-cmd-toggle-star)
nnoremap èse <Plug>(vimtex-env-toggle-star)
