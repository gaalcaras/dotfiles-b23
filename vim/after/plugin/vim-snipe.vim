" vim-snipe
if ! exists('g:snipe_jump_tokens')
  finish
endif

nmap <leader>sf <Plug>(snipe-f)
nmap <leader>sF <Plug>(snipe-F)
nmap <leader>st <Plug>(snipe-t)
nmap <leader>sT <Plug>(snipe-T)
nmap <leader>sé <Plug>(snipe-w)
nmap <leader>sÉ <Plug>(snipe-W)
nmap <leader>sb <Plug>(snipe-b)
nmap <leader>sB <Plug>(snipe-B)
nmap <leader>sgé <Plug>(snipe-ge)
nmap <leader>sgÉ <Plug>(snipe-gE)
nmap <leader>sx <Plug>(snipe-f-xp)
nmap <leader>sX <Plug>(snipe-F-xp)
let g:snipe_jump_tokens = 'auiectsrnmbépo'
