inoremap <C-Space> <C-x><C-o>

iabbrev % %>%

autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

augroup ncmr
  autocmd BufEnter *.R call ncm2#enable_for_buffer()
  autocmd BufEnter *.R setlocal completeopt=noinsert,menuone,noselect
augroup END
