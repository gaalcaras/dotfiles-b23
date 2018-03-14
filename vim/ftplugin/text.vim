function! ToggleCheckmark() abort
  let l:cur_pos = getpos('.') " Save current position

  let l:cur_line=getline('.')
  let l:check=matchstr(l:cur_line, '\[.\]')[1]

  if l:check=="x"
    s/\[x\]/\[ \]/
  else
    s/\[ \]/\[x\]/
  endif

  call setpos('.', l:cur_pos) " Go back to original position
  %sort
endfunction

function! SearchForChecklistItem() abort
  let l:cur_pos = getpos('.') " Save current position

  let l:cur_line=getline('.')
  let l:check=matchstr(l:cur_line, '\[.\]')[1]

  if l:check!=""
    let l:item=matchstr(l:cur_line, '\].*$')[1:]

    silent execute '!$BROWSER "https://duckduckgo.com/\?q=\!g ' . l:item . '"'
  call setpos('.', l:cur_pos) " Go back to original position
  endif

  call ToggleCheckmark()
endfunction

nnoremap <silent> <CR> :call ToggleCheckmark()<CR>
nnoremap <silent> <Space> :call SearchForChecklistItem()<CR>
