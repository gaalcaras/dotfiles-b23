" nvim-ipy (mappings in ftplugin)
if ! exists(':IPython')
  finish
endif

let g:nvim_ipy_perform_mappings = 0

map <localleader>ll <Plug>(IPy-Run)
map <localleader>pp vip<Plug>(IPy-Run)
map <localleader>cc <Plug>(IPy-RunCell)
map <localleader>rp <Plug>(IPy-WordObjInfo)
map <localleader>rf :IPython<CR><C-W>H
