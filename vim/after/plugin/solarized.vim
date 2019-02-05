silent! colorscheme solarized8_high

function! solarized#updateColors(theme)
  exec 'set background=' . a:theme

  " Highlight groups for status bar
  silent! exec "hi User1 guibg=" . g:terminal_color_2 . " guifg=" . g:terminal_color_0
  silent! exec "hi User2 guibg=" . g:terminal_color_3 . " guifg=" . g:terminal_color_0
endfunction

let s:dark=system('grep "# COLORS - SOLARIZED DARK" "$HOME/.config/i3/config"')

if s:dark == ''
  call solarized#updateColors('light')
else
  call solarized#updateColors('dark')
endif
