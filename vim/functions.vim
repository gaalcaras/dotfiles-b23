" If buffer modified, update any 'lastmodified: ' in the first 20 lines.
" 'lastmodified: 2016-01-13 16:51:48
" Restores cursor and window position using save_cursor variable.

function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Dernière modification : \)$#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun

" When new file is created, edit any 'date: ' in the first 20 lines.
" 'date: ' can have up to 10 characters before (they are retained). 
" Restores cursor and window position using save_cursor variable.

function! DateCreated()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Date de création      : \).*#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun

" When new file is created, add the time id on the first line.

function! DateID()
  if &modified
    let save_cursor = getpos(".")

    " autocmd can be called twice, so we check that the first
    " character on the first line is not the beginning of a date
    exe '1s#^\([^2]\)#' .  strftime('%Y%m%d%H%M') . ' \1#e'
    call histdel('search', -1)

    " Move cursor after time id
    call setpos('.', [0, 1, 14])
  endif
endfun
