" Avoid strange behavior of smart indent with comments
setl nosmartindent

map <localleader>ll <Plug>(IPy-Run)
map <localleader>pp vip<Plug>(IPy-Run)
map <localleader>cc <Plug>(IPy-RunCell)
map <localleader>rp <Plug>(IPy-WordObjInfo)
map <localleader>rf :IPython<CR><C-W>H
