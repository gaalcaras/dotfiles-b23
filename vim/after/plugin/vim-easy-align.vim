" vim-easy-align
if ! exists(':EasyAlign')
  finish
endif

vmap <Enter> <Plug>(LiveEasyAlign)
nmap ga <Plug>(LiveEasyAlign)
