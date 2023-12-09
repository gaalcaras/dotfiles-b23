scriptencoding utf8

set path+=$HOME/inbox/notes/**
setlocal suffixesadd+=.md

setlocal ignorecase " Case doesn't matter in notes
setlocal textwidth=79

" Format pasted text into a proper markdown quote
function! markdown#formatQuote()
  " Remove all indentation
  execute 'normal! vap<<<\<esc>'
  " Join all lines in the paragraph
  execute "normal! :'<,'>join\<cr>"
  " Add a line before paragraph then go to the paragraph
  execute 'normal! O'
  execute 'normal! j'
  " Replace all hyphens with whole words (e: silent if pattern not found)
  s/\(\w\)[-−¬]\s\(\w\)/\1\2/ge
  " Replace all weird quotes with normal quotes (silently as well)
  s/’/'/ge
  " Remove double spaces (silently as well)
  s/ \+/ /ge
  " Remove weird artefacts
  s/�//ge
  " Prepend quote symbol '>' to the line
  execute 'normal! 0i> '
  " And hard wrap the paragraph
  execute 'normal! gq}'
endfunction

function! markdown#insertQuote()
  let l:xsel_cmds = ['xsel -b', 'xsel -p']
  let l:xsel = ''
  for cmd in l:xsel_cmds
    let l:result = system(cmd)
    echomsg cmd ': [' . l:result . '] == ' . empty(l:result)
    if empty(l:result) == 0
      let l:xsel = l:result
    endif
  endfor

  echomsg 'l:xsel = ' . l:xsel
  echomsg 'empty = ' . empty(l:xsel)
  if empty(l:xsel) == 0
    execute 'normal! O'
    call append('.', split(l:xsel, '\n'))
    call markdown#formatQuote()
    execute 'normal! o'
  endif
endfunction

map gf :e <cfile><CR>
map <Localleader>lv :call dotfiles#CompileMarkdown(1)<CR>
map <Localleader>ll :!$TERM -e glow % -p<CR>
map <Localleader>q :call markdown#formatQuote()<CR>

augroup markdown
  autocmd!
  autocmd BufWritePre * call dotfiles#LastModified("lastmodified")
  " Open all folds when opening
  autocmd BufEnter * normal zR
augroup END

" Some useful completion when taking notes
inoremap <buffer> « ""<C-G>U<Left><Left>
inoremap <buffer> » "<C-G>U<Left><Left>

call dotfiles#UndoChunks()
call dotfiles#ForceNonBreakingSpacePunctuation()

" Markdown preview settings

" Autostart by opening browser
let g:mkdp_auto_start = 0
let g:mkdp_browser = 'markdown_composer_browser'
let g:mkdp_auto_close = 0
