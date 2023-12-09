call dotfiles#ForceNonBreakingSpacePunctuation()

function! mail#prepEmail()
  " If buffer is empty, do nothing
  if line('$') == 1 && getline(1) == ''
    return
  endif

  " If buffer already contains formatted content, do nothing
  if search("^On ", "cn", 1) == 0
    return
  endif

  " Remove trailing email replies (prevent >>>>>)

  " Go to the end of the document and look for last line with quoted reply
  normal G
  let l:trailing = search("^>>", "b")

  if l:trailing > 0
    " If email contains quoted reply, then go to first line that introduced it
    " then delete everything below it
    call search("^>\\s\\?\\(Le\\|On\\)", "b")
    normal dG
  endif

  " Break emails into paragraphs...

  " When sentence ends with punctuation followed by line break and text
  2,$s/\([\?\.,:!]\)\n\(>\S\)/\1\r\r\2/ge

  " When sentence begins with a list item preceded by a line break and
  " text
  2,$s/\(\S\)\n\(>\s*[-\*\+]\)/\1\r\r\2/ge

  " Start by wrapping quoted email
  normal gg
  normal gqG
  " Remove empty lines between paragraphs
  execute "%s/\^>$//ge"

  " Remove double line breaks
  %s/\n\n\n*/\r\r/ge
  normal gg
  normal gq}
  " Remove empty lines between paragraphs
  execute "%s/\^>$//ge"

  " Remove double line breaks
  %s/\n\n\n*/\r\r/ge
  normal gg

  " Write some generic greeting formula
  let l:regex_name = "^On .*, \\(.*\\) wrote:"
  let l:name = substitute(getline(search(l:regex_name)), l:regex_name, "\\1", "g")
  let l:firstname = split(substitute(l:name, '\C[A-Z]\{2,\}', '', 'g'))[0]

  let l:greeting = "Bonjour"
  if search("\\<tu\\>\\|\\<toi\\>\\|\\<te\\>", "n") > 0
    let l:greeting = "Salut"
  else
    if strftime("%H") > 18
      let l:greeting = "Bonsoir"
    endif
  endif

  normal gg
  execute "normal! O" . l:greeting . " " . l:firstname . ",\<cr>"
endfunction

function! mail#cleanEmail()
  silent! g/\(^>.*$\n^\)$/,/^$\n^>\S/s/^$/>/ge
endfunction

augroup markdown
  autocmd!
  autocmd! BufEnter * call mail#prepEmail()
augroup END

nnoremap <leader>m :silent exec "!tmux split-window -h 'neomutt -R'"<cr>
nnoremap <leader>c :call mail#cleanEmail()<cr>
