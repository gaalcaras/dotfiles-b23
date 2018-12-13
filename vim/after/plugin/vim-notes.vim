" vim-notes
if ! exists(':Note')
  finish
endif

let g:notes_directories = ['~/Zettelkasten/zettel']
let g:notes_new_note_template = '~/Zettelkasten/new_zettel'
let g:notes_title_sync = 'rename_file'

let g:notes_smart_quotes = 0
