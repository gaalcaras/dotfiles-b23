" Ultisnips
if ! exists('g:UltiSnipsEditSplit')
  finish
endif

" Other mappings
let g:UltiSnipsListSnippets='<c-tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir='.vim/myownsnips'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'myownsnips']

" UltiSnips + NCM
" See: https://github.com/ncm2/ncm2-ultisnips/issues/6#issuecomment-410186456

" Disable UltiSnips mappings
let g:UltiSnipsExpandTrigger       = "<Plug>(ultisnips_expand_or_jump)"
let g:UltiSnipsJumpForwardTrigger  = "<Plug>(ultisnips_expand_or_jump)"

" Try expanding/jumping with UltiSnips, return <Tab> if nothing worked.
function! UltiSnipsExpandOrJumpOrTab()
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  else
    return "\<Tab>"
  endif
endfunction
