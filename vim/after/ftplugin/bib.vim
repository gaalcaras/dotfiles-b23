"""""""""""""""
"  Functions  "
"""""""""""""""

" Open buffer to input new reference
function! bib#openNewRefBuffer(...)
  let l:tmpfile = system('mktemp /tmp/new-XXXXXXXXXXXXX.bib')
  execute "silent! split " . l:tmpfile
  let b:pdfkey = exists('a:1') ? a:1 : ''
  nnoremap <buffer> CC :call <SID>mergeNewReference()<cr>

  execute "normal! i%Press CC to merge reference to master file"
  execute "normal! o"

  execute ":Snippets"
endfun

" Add email reference to bib file
function! bib#addEmailRef()
  let l:tmpfile = system('mktemp /tmp/new-XXXXXXXXXXXXX.bib')
  execute "silent! split " . l:tmpfile
  nnoremap <buffer> CC :call <SID>mergeNewReference('emails.bib')<cr>

  execute "normal! i%Press CC to merge reference to master file\<CR>"
  execute "normal! iemail\<C-r>=UltiSnips#ExpandSnippet()\<CR>"
endfunction

" Merge new reference buffer to master bib file
function! <SID>mergeNewReference(...)
  execute 'w'
  let l:buffer_main = exists('a:1') ? a:1 : 'master.bib'
  let l:tmpfile = expand('%')
  let l:pdfkey = exists('b:pdfkey') ? b:pdfkey : ''

  " Get BibKey
  execute 'normal! }'
  let l:key = bib#getBibKey()

  execute 'w'

  " Switch to master buffer, read new reference buffer, close current
  " buffer, sort master buffer and go to new added reference.
  execute "buffer " . l:buffer_main
  execute "0read " . l:tmpfile
  execute 'wq'
  execute "bdelete ". l:tmpfile
  call bib#sort()
  execute "/" . l:key

  call bib#addRefToInbox(l:key)

  if empty(l:pdfkey) | return | endif

  execute 'silent !mkdir -p $BIB_PDF_DIR/' . l:key[0]
  execute 'silent !mv /tmp/' . l:pdfkey . '.pdf ' .
        \ '$BIB_PDF_DIR/' . l:key[0] . '/' . l:key . '.pdf'
endfun

" Sort current bib file by BibKey
function! bib#sort()
  execute "%!bibtool -r biblatex -R -q -s %"
endfun

" Get BibKey of selected reference
function! bib#getBibKey()
  " Get line number of first line of reference
  let l:refline = bib#getRefBounds()[0]
  let l:bibkey = substitute(getline(l:refline),
        \ '^@.*{\s*\(.*\),$',
        \ '\=submatch(1)', 'g')
  if empty(l:bibkey) | echo "Could not find bib key" | return | endif
  return l:bibkey
endfun

" Get bounds of the reference under the cursor
" Returns a list of 2 line numbers (first_line_of_ref, last_line_of_ref)
function! bib#getRefBounds()
  " Save position
  let l:cur_pos = getcurpos()

  " Get line number of first line of reference
  let l:ref_start = search('^@', 'bnc', 1)

  " Go to end of reference (using matching curly brackets)
  execute "normal! " . l:ref_start . "gg^f{%"
  let l:ref_end = line('.')

  " Return to initial position
  call setpos('.', l:cur_pos)

  return [l:ref_start, l:ref_end]
endfunction

" Find if reference under cursor contains a Keywords field
function! bib#hasKeywordsField()
  " Save position
  let l:cur_pos = getcurpos()

  let l:ref_bounds = bib#getRefBounds()
  call cursor(l:ref_bounds[0], 1)

  let l:result = search('Keywords ', 'cn', l:ref_bounds[1])

  " Return to initial position
  call setpos('.', l:cur_pos)

  return l:result
endfunction

" Add a Keywords field to current reference
function! bib#addKeywordsField()
  " Save position
  let l:cur_pos = getcurpos()

  " Do nothing if there's already a Keywords field
  if bib#hasKeywordsField() > 0 | return | endif

  let l:ref_bounds = bib#getRefBounds()

  " Go to before-to-last line
  execute 'normal! ' . (l:ref_bounds[1]-1) . 'gg'

  " Add Keywords field
  execute "normal! A,\<cr>Keywords      = {}"

  " Return to initial position
  call setpos('.', l:cur_pos)
endfunction

" Toggle a reference between two keywords.
" keywords : list of two keywords, first one is the default 'on' position
" target : [optional] target position for the switch. If it's already on the
"          target position, then the function does nothing.
function! bib#toggleKeyword(keywords, ...)
  " Save position
  let l:cur_pos = getcurpos()
  let l:on = a:keywords[0]
  let l:off = a:keywords[1]
  let l:target = exists('a:1') ? a:1 : ''

  let l:keywords_l = bib#hasKeywordsField()

  " Create a Keywords field if none exists
  if l:keywords_l == 0
    call bib#addKeywordsField()
    " ... And start again
    call bib#toggleKeyword([l:on, l:off], l:target)
    return
  endif

  " Move to Keywords field line
  call cursor(l:keywords_l, 1)

  " Final switch position (target by default)
  let l:switch_position = l:target

  if search(l:on, 'cn', l:keywords_l) > 0 && l:target != l:on
    " If reference is 'on' (and that's not the target position),
    " switch it 'off'
    execute 's/' . l:on . '/' . l:off . '/'
    let l:switch_position = l:off
  elseif search(l:off, 'cn', l:keywords_l) > 0 && l:target != l:off
    " If reference is 'off' (and that's not the target position),
    " switch it 'on'
    execute 's/' . l:off . '/' . l:on . '/'
    let l:switch_position = l:on
  elseif search(l:on . '\|' . l:off, 'cn', l:keywords_l) == 0
    " If it's neither on or off (it has none of the keywords)...
    "
    let l:default = (l:target == '') ? l:on : l:target

    if search('{}', 'cn', l:keywords_l) > 0
      " If the keywords field is empty, add the 'on' keyword.
      execute 's/{/{' . l:default . '/'
    else
      " If the keywords field is already populated,
      " prepend the 'on' keyword to the list.
      execute 's/{/{' . l:default . ', /'
    endif
    let l:switch_position = l:default
  endif

  " Return to initial position
  call setpos('.', l:cur_pos)

  return l:switch_position
endfunction

" Switch read status of current reference
function! bib#toggleRead()
  let l:result = bib#toggleKeyword(['inbox', 'read'])
  if l:result == 'inbox'
    call bib#addRefToInbox()
  elseif l:result == 'read'
    call bib#rmRefFromInbox()
  endif
endfunction

" Add PDF and reference
function! bib#addPDFAsReference()
  " Generate 13 random alphanum chars
  let l:tmpid = '_' . system('head /dev/urandom | ' .
        \ 'tr -dc A-Za-z0-9 | head -c 13')

  let callback = { 'pdfid': l:tmpid }
  function! callback.after_exit()
    call bib#openPDF(self.pdfid)
    call bib#openNewRefBuffer(self.pdfid)
  endfunction

  call bib#getPDF(l:tmpid, callback)
endfunction

" Add PDF of selected reference
function! bib#getPDFOfReference()
  let l:ref = bib#getBibKey()
  call bib#getPDF(l:ref, {})
endfunction

" Associate PDF file with selected reference
function! bib#getPDF(bibkey, callback)
  if empty(a:bibkey) | return | endif

  let callback = a:callback
  function! callback.on_exit(job_id, code, event)
    " Close the terminal window when done
    if a:code == 0
      " If no error, do what's next
      silent! bd!
      if has_key(self, 'after_exit')
        call self.after_exit()
      endif
    elseif a:code == 1
      " If error, just close the damn terminal
      silent! bd!
    endif

    " If we successfully retrieved a file,
    " then mark reference as having a file
    if v:shell_error == 0
      call bib#toggleKeyword(['nofile', 'hasfile'], 'hasfile')
    endif
  endfunction

  " Open terminal in new window and start in insert mode
  wincmd n
  call termopen('getpdf ' . a:bibkey, callback)
  startinsert
endfun

" Open PDF file associated with BibKey
function! bib#openPDF(bibkey)
  silent execute "!openpdf " . a:bibkey

  if v:shell_error == 0
    " If there's no file to be found, then mark reference as missing a file
    call bib#toggleKeyword(['nofile', 'hasfile'], 'hasfile')
  elseif v:shell_error == 2
    " If there's no file to be found, then mark reference as missing a file
    call bib#toggleKeyword(['nofile', 'hasfile'], 'nofile')
  endif
endfun

function! bib#openPDFOfReference()
  let l:ref = bib#getBibKey()
  call bib#openPDF(l:ref)
endfunction

" Take notes on selected reference
function! bib#note()
  let l:ref = bib#getBibKey()
  silent execute "!mkdir -p $BIB_NOTES_DIR/". l:ref[0]
  execute "vsplit $BIB_NOTE_DIR/" . l:ref[0] . "/" . l:ref . ".md"
endfunction

" Add reference to inbox
function! bib#addRefToInbox(...)
  let l:key = exists('a:1') ? a:1 : bib#getBibKey()
  wa
  execute "silent !ref_to_inbox " . l:key
endfunction

" Remove reference from inbox
function! bib#rmRefFromInbox(...)
  let l:key = exists('a:1') ? a:1 : bib#getBibKey()
  wa
  execute "silent !ref_rm_inbox " . l:key
endfunction

" Replace underscores with spaces after completion
fun! <SID>DoAfterCompletion()
  " Save cursor position
  let l:save_cursor = getpos(".")

  " Get word we just completed ('borrowed' from: http://stackoverflow.com/a/23541748/660921)
  let l:word = matchstr(strpart(getline('.'), 0, col('.') - 1), '\k\+$')

  " Replace _ with space
  let l:new = substitute(l:word, "_", " ", "g")

  " Run :s
  exe "s/" . l:word . "/" . l:new . "/e"

  " Restore cursor
  call setpos(".", l:save_cursor)
endfunction

" Replace underscores with spaces after completion
function! bib#goToRef()
  " Get initial position and buffer
  let l:cur_pos = getcurpos()
  let l:buf_start = expand("%:t")

  " If we're in the inbox file, then go to the ref word
  if l:buf_start =~ "inbox"
    normal! ^f,w
  endif

  " Get the ref, go to the ref in the other buffer
  normal! *
  sbuffer master.bib
  normal! n
  normal! zz

  " Reset to the original position
  execute "sbuffer " . l:buf_start
  call setpos('.', l:cur_pos)
endfunction

""""""""""""""
"  Commands  "
""""""""""""""

command! BibAddRef call bib#openNewRefBuffer()
command! BibAddPDFAsRef call bib#addPDFAsReference()
command! BibSort call bib#sort()
command! BibGetPDF call bib#getPDFOfReference()
command! BibOpenPDF call bib#openPDFOfReference()
command! BibNote call bib#note()
command! BibSwitchRead call bib#toggleRead()

let g:UltiSnipsJumpForwardTrigger = '<C-n>'
let g:UltiSnipsJumpBackwardTrigger = '<C-p>'

""""""""""""""
"  Mappings  "
""""""""""""""

nnoremap <leader>a :BibAddRef<cr>
nnoremap <leader>A :BibAddPDFAsRef<cr>
nnoremap <leader>s :BibSort<cr>
nnoremap <leader>g :BibGetPDF<cr>
nnoremap <leader><cr> :BibOpenPDF<cr>
nnoremap <leader>n :BibNote<cr>
nnoremap <leader>i :vsplit $BIB_DIR/inbox<cr>
nnoremap <leader>r :source $HOME/.dotfiles/vim/after/ftplugin/bib.vim<cr>
nnoremap <leader>+ :call bib#addRefToInbox()<cr>
nnoremap <C-g> :call bib#goToRef()<cr>

nnoremap <C-Space> :BibSwitchRead<cr>

nnoremap <localleader>a :BLines author\s*=<cr>
nnoremap <localleader>t :BLines title\s*=<cr>

nnoremap <C-n> /@<cr>zz:noh<cr>
nnoremap <C-p> ?@<cr>zz:noh<cr>

""""""""""""""""""
"  Autocommands  "
""""""""""""""""""

augroup bib
  autocmd!
  autocmd BufEnter *.bib ++once Limelight
  autocmd TermOpen *.bib term://* startinsert
  autocmd BufWinLeave *.bib if exists('g:bibdata') | unlet g:bibdata | endif
  " autocmd CompleteDone *.bib call <SID>DoAfterCompletion()
augroup END
