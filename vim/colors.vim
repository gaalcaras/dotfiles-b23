if !exists('g:colors_name') || g:colors_name != 'solarized8_dark'
  colorscheme solarized8_dark
endif

nnoremap  <localleader>B :<c-u>exe "colors" (g:colors_name =~# "dark"
    \ ? substitute(g:colors_name, 'dark', 'light', '')
    \ : substitute(g:colors_name, 'light', 'dark', '')
    \ )<cr>
