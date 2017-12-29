" ########################################
" Useful functions for my vimrc
" by @gaalcaras

scriptencoding utf8

" Build function for vim-markdown-composer
function! dotfiles#BuildComposer(info)
  if a:info.status !=# 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" Useful for writing vim documentation: right align text by inserting
" n spaces at current cursor position.
function! dotfiles#AlignWithSpaces(last_col) abort
  let l:cur_pos = getpos('.') " Save current position

  " Go to first double space in line and save position
  execute "normal! ^/\\s\\s\<cr>"
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

" If buffer modified, update any 'lastmodified: ' in the first 20 lines.
" 'lastmodified: 2016-01-13 16:51:48
" Restores cursor and window position using save_cursor variable.
function! dotfiles#LastModified(prefix)
  let l:save_cursor = getpos('.')
  let l:n = min([20, line('$')])
  keepjumps exe '1,' . l:n . 's#^\(.\{,10}' . a:prefix . '\s*: \).*$#\1'.
        \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
  call histdel('search', -1)
  call setpos('.', l:save_cursor)
endfun

" When new file is created, edit any 'date: ' in the first 20 lines.
" 'date: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! dotfiles#DateCreated(prefix)
  if &modifiable
    let l:save_cursor = getpos('.')
    let l:n = min([20, line('$')])
    keepjumps exe '1,' . l:n . 's#^\(.\{,10}' . a:prefix . '\s*: \)$#\1' .
          \ strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', l:save_cursor)
  endif
endfun

" When new file is created, add the time id on the first line.
function! dotfiles#DateID()
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

" Define new text objects with delimiters : **, --, __, etc.
function! dotfiles#DefineNewTextObjects(arr_delimiters) abort
  for l:char in a:arr_delimiters
    execute 'xnoremap i' . l:char . ' :<C-u>normal! T'
          \ . l:char . 'vt' . l:char . '<cr>'
    execute 'onoremap i' . l:char . ' :normal vi'
          \ . l:char . '<cr>'
    execute 'xnoremap a' . l:char . ' :<C-u>normal! F'
          \ . l:char . 'vf' . l:char . '<cr>'
    execute 'onoremap a' . l:char . ' :normal va'
          \ . l:char . '<cr>'
  endfor
endfunction

" HARDMODE, adpated from this gist to bépo layout:
" https://gist.github.com/jeetsukumaran/96474ebbd00b874f0865
function! dotfiles#DisableIfNonCounted(move) range
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

function! dotfiles#SetDisablingOfBasicMotionsIfNonCounted(on)
  let l:keys_to_disable = get(g:, 'keys_to_disable_if_not_preceded_by_count',
        \ ['c', 't', 's', 'r'])
  if a:on
    for l:key in l:keys_to_disable
      execute 'noremap <expr> <silent> ' . l:key
            \ . " dotfiles#DisableIfNonCounted('" . l:key . "')"
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

function! dotfiles#ToggleDisablingOfBasicMotionsIfNonCounted()
  let l:is_disabled = get(g:, 'is_non_counted_basic_motions_disabled', 0)
  if l:is_disabled
    call dotfiles#SetDisablingOfBasicMotionsIfNonCounted(0)
  else
    call dotfiles#SetDisablingOfBasicMotionsIfNonCounted(1)
  endif
endfunction

function! dotfiles#OpenPluginHomepage() abort
   " Get line under cursor
  let l:line = getline('.')

  " Matches for instance Plug 'tpope/surround' -> tpope/surround
  " Non-greedy match in order to not capture trailing comments
  let l:plugin_name = '\w\+ \([''"]\)\(.\{-}\)\1'
  let l:repository = matchlist(l:line, l:plugin_name)[2]

  " Open the corresponding GitHub homepage with $BROWSER
  silent exec '!$BROWSER https://github.com/'.l:repository
endfunction

" Make small undo chunks for writing prose
function! dotfiles#UndoChunks() abort
  inoremap . .<c-g>u
  inoremap ? ?<c-g>u
  inoremap ! !<c-g>u
  inoremap : :<c-g>u
  inoremap , ,<c-g>u
  inoremap ; ;<c-g>u
endfunction

function! dotfiles#CompileMarkdown(open_pdf)
   let l:cur_file = expand('%:p')
   let l:cur_dir = expand('%:h')
   let l:file_root = expand('%:t:r')
   let l:pdf_file = l:cur_dir . '/' . l:file_root . '.pdf'
   write

   let l:instruction = '! pandoc ' . l:cur_file .
               \ ' -f markdown -t latex -s --toc -V geometry:margin=1in -o ' .
               \ l:pdf_file

   if a:open_pdf == 1
     let l:instruction = l:instruction . ' && evince ' .
           \ l:pdf_file
   endif

   silent !clear
   execute l:instruction
endfun

function ExpandYamlNote() abort
  let l:first_line = getline(1)

  if l:first_line !=# '---'
    execute "normal! iyaml_note\<C-r>=UltiSnips#ExpandSnippet()\<CR>"
  endif
endfunction
