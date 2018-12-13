inoremap <C-Space> <C-x><C-o>

iabbrev % %>%

autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
