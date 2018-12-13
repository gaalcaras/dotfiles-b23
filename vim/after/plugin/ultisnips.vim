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

" First try expanding with ncm2_ultisnips. This does both LSP snippets and
" normal snippets when there's a completion popup visible.
inoremap <silent> <expr> <Tab> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_try_expand)")

" If that failed, try the UltiSnips expand or jump function. This handles
" short snippets when the completion popup isn't visible yet as well as
" jumping forward from the insert mode. Writes <Tab> if there is no special
" action taken.
inoremap <silent> <Plug>(ultisnips_try_expand) <C-R>=UltiSnipsExpandOrJumpOrTab()<CR>

" Select mode mapping for jumping forward with <Tab>.
snoremap <silent> <Tab> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
