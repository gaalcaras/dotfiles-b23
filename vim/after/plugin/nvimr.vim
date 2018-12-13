" Nvim-R
if ! exists(':RSend')
  finish
endif

let g:r_syntax_folding = 1
let g:R_assign = 0 " Do not expand _ to <-
let g:R_clear_line = 1 " Always clear line in the R Console
let R_start_libs = "base,stats,graphics,grDevices,utils,methods,datasets"
