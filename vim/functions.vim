" ########################################
" Useful functions for my vimrc
" by @gaalcaras

scriptencoding utf8

" Useful for writing vim documentation: right align text by inserting
" n spaces at current cursor position.
function! AlignWithSpaces(last_col) abort
  let l:cur_pos = getpos('.') " Save current position

  " Go to first space in line and save position
  normal! ^f 
  let l:first_space_pos = getpos('.')

  " Go to end of the line and compute difference
  normal! g$
  let l:end_col = getpos('.')[2]
  let l:nb_spaces = a:last_col-l:end_col

  " Go back to the first space in line
  call setpos('.', l:first_space_pos)

  " Either add or remove spaces
  if l:nb_spaces >= 0
    exe ':normal i' . repeat(' ', l:nb_spaces)
  else
    exe ':s/\s\{' . abs(l:nb_spaces) . '\}//'
  endif

  call setpos('.', l:cur_pos) " Go back to original position
endfunction

function! ToggleSolarizedDarkTheme() abort
  if g:colors_name =~# 'dark'
    let g:colors_name = substitute(g:colors_name, 'dark', 'light', '')
  else
    let g:colors_name = substitute(g:colors_name, 'light', 'dark', '')
  endif
  exe 'colors ' . g:colors_name
endfunction

" If buffer modified, update any 'lastmodified: ' in the first 20 lines.
" 'lastmodified: 2016-01-13 16:51:48
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let l:save_cursor = getpos('.')
    let l:n = min([20, line('$')])
    keepjumps exe '1,' . l:n . 's#^\(.\{,10}Dernière modification : \).*$#\1'.
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', l:save_cursor)
  endif
endfun

" When new file is created, edit any 'date: ' in the first 20 lines.
" 'date: ' can have up to 10 characters before (they are retained). 
" Restores cursor and window position using save_cursor variable.
function! DateCreated()
  if &modifiable
    let l:save_cursor = getpos('.')
    let l:n = min([20, line('$')])
    keepjumps exe '1,' . l:n . 's#^\(.\{,10}Date de création      : \)$#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', l:save_cursor)
  endif
endfun

" When new file is created, add the time id on the first line.
function! DateID()
  if &modifiable
    if (&filetype ==# 'notes')
      let l:save_cursor = getpos('.')

      " autocmd can be called twice, so we check that the first
      " character on the first line is not the beginning of a date
      exe '1s#^\([^2]\)#' .  strftime('%Y%m%d%H%M') . ' \1#e'
      call histdel('search', -1)

      " Move cursor after time id
      call setpos('.', [0, 1, 14])
    endif
  endif
endfun

" HARDMODE, adpated from this gist to bépo layout:
" https://gist.github.com/jeetsukumaran/96474ebbd00b874f0865
function! DisableIfNonCounted(move) range
  if v:count
    if a:move ==? 'c'
      return 'h'
    elseif a:move ==? 't'
      return 'j'
    elseif a:move ==? 's'
      return 'k'
    elseif a:move ==? 'r'
      return 'l'
    else
      return a:move
    endif
  else
    return ''
  endif
endfunction

function! SetDisablingOfBasicMotionsIfNonCounted(on)
  let l:keys_to_disable = get(g:, 'keys_to_disable_if_not_preceded_by_count',
        \ ['c', 't', 's', 'r'])
  if a:on
    for l:key in l:keys_to_disable
      execute 'noremap <expr> <silent> ' . l:key . " DisableIfNonCounted('"
            \ . l:key . "')"
    endfor
    let g:keys_to_disable_if_not_preceded_by_count = l:keys_to_disable
    let g:is_non_counted_basic_motions_disabled = 1
  else
    for l:key in l:keys_to_disable
      try
        execute 'unmap ' . l:key
        execute 'noremap c h'
        execute 'noremap r l'
        execute 'noremap t j'
        execute 'noremap s k'
      catch /E31:/
        endtry
    endfor
      let g:is_non_counted_basic_motions_disabled = 0
    endif
endfunction

function! ToggleDisablingOfBasicMotionsIfNonCounted()
  let l:is_disabled = get(g:, 'is_non_counted_basic_motions_disabled', 0)
  if l:is_disabled
    call SetDisablingOfBasicMotionsIfNonCounted(0)
  else
    call SetDisablingOfBasicMotionsIfNonCounted(1)
  endif
endfunction

command! ToggleDisablingOfNonCountedBasicMotions
      \ :call ToggleDisablingOfBasicMotionsIfNonCounted()
command! DisableNonCountedBasicMotions
      \ :call SetDisablingOfBasicMotionsIfNonCounted(1)
command! EnableNonCountedBasicMotions
      \ :call SetDisablingOfBasicMotionsIfNonCounted(0)
