" Transcribe.nvim
function! s:transcribe_map()
  imap <silent><buffer> <C-S> <plug>(transcribe-speed-inc)
  nmap <silent><buffer> <leader>s <plug>(transcribe-speed-inc)
  imap <silent><buffer> <C-t> <plug>(transcribe-speed-dec)
  nmap <silent><buffer> <leader>t <plug>(transcribe-speed-dec)
  imap <silent><buffer> <C-c> <plug>(transcribe-seek-backward)
  nmap <silent><buffer> <leader>c <plug>(transcribe-seek-backward)
  imap <silent><buffer> <C-r> <plug>(transcribe-seek-forward)
  nmap <silent><buffer> <leader>r <plug>(transcribe-seek-forward)
  imap <silent><buffer> <C-v> <plug>(transcribe-timepos-get)
  imap <silent><buffer> <C-p> <plug>(transcribe-sync)
endfunction

augroup TranscribeMappings
  autocmd!
  autocmd FileType markdown,text call s:transcribe_map()
augroup END
