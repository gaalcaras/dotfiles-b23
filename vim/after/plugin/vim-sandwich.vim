" vim-sandwich with surround mappings
if ! exists('g:loaded_sandwich')
  finish
endif

nmap ys <Plug>(operator-sandwich-add)
nmap ls <Plug>(operator-sandwich-replace)
      \<Plug>(operator-sandwich-release-count)
      \<Plug>(textobj-sandwich-query-a)
nmap ds <Plug>(operator-sandwich-delete)
      \<Plug>(operator-sandwich-release-count)
      \<Plug>(textobj-sandwich-query-a)
