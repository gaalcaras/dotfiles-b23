" Gitgutter
if ! exists(':GitGutter')
  finish
endif

nnoremap <c-n> :GitGutterNextHunk<CR>
nnoremap <c-p> :GitGutterPrevHunk<CR>
nnoremap <c-u> :GitGutterUndoHunk<CR>
