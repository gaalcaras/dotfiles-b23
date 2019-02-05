" typit-learn
if ! exists(':TypitLearnRecord')
  finish
endif

let g:tplearn_log = '~/logs/tplearn.log'
let g:tplearn_log_level = 'debug'
let g:tplearn_dir = '~/.dotfiles/vim/tplearn'
let g:tplearn_spellcheck = 1
