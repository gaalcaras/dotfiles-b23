" ########################################
" Useful functions
"
" by Gabriel Alcaras
"
" ########################################

" Dates {{{

" If buffer modified, update any 'lastmodified: ' in the first 20 lines.
" 'lastmodified: 2016-01-13 16:51:48
" Restores cursor and window position using save_cursor variable.

function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Dernière modification : \).*$#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun

" When new file is created, edit any 'date: ' in the first 20 lines.
" 'date: ' can have up to 10 characters before (they are retained). 
" Restores cursor and window position using save_cursor variable.

function! DateCreated()
  if &modifiable
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Date de création      : \)$#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun

" When new file is created, add the time id on the first line.

function! DateID()
  if &modifiable
    if (&ft == 'notes')
      let save_cursor = getpos(".")

      " autocmd can be called twice, so we check that the first
      " character on the first line is not the beginning of a date
      exe '1s#^\([^2]\)#' .  strftime('%Y%m%d%H%M') . ' \1#e'
      call histdel('search', -1)

      " Move cursor after time id
      call setpos('.', [0, 1, 14])
    endif
  endif
endfun

" }}}
" Hardmode {{{

" Inspired from this gist :
" https://gist.github.com/jeetsukumaran/96474ebbd00b874f0865
" and adapted to bépo layout

function! DisableIfNonCounted(move) range
    if v:count
      if a:move == 'c'
        return "h"
      elseif a:move == 't'
        return "j"
      elseif a:move == 's'
        return "k"
      elseif a:move == 'r'
        return "l"
      else
        return a:move
      endif
    else
        return ""
    endif
endfunction

function! SetDisablingOfBasicMotionsIfNonCounted(on)
    let keys_to_disable = get(g:, "keys_to_disable_if_not_preceded_by_count", ["c", "t", "s", "r"])
    if a:on
        for key in keys_to_disable
            execute "noremap <expr> <silent> " . key . " DisableIfNonCounted('" . key . "')"
        endfor
        let g:keys_to_disable_if_not_preceded_by_count = keys_to_disable
        let g:is_non_counted_basic_motions_disabled = 1
    else
        for key in keys_to_disable
            try
                execute "unmap " . key
                execute "noremap c h"
                execute "noremap r l"
                execute "noremap t j"
                execute "noremap s k"
            catch /E31:/
            endtry
        endfor
        let g:is_non_counted_basic_motions_disabled = 0
    endif
endfunction

function! ToggleDisablingOfBasicMotionsIfNonCounted()
    let is_disabled = get(g:, "is_non_counted_basic_motions_disabled", 0)
    if is_disabled
        call SetDisablingOfBasicMotionsIfNonCounted(0)
    else
        call SetDisablingOfBasicMotionsIfNonCounted(1)
    endif
endfunction

command! ToggleDisablingOfNonCountedBasicMotions :call ToggleDisablingOfBasicMotionsIfNonCounted()
command! DisableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(1)
command! EnableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(0)

" }}}
