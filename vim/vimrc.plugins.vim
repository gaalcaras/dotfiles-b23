" ###########################
" GRUVBOX: colorscheme config
" ###########################

silent! let g:gruvbox_italic=1
silent! colorscheme gruvbox 
silent! set background=dark

" ###########################
" UNITE: plugin config
" ###########################

" Add fuzzy search for files (Ctrlp like)
nnoremap <C-p> :Unite file_rec/async<cr>

" Add content searching (ag.vim like)
nnoremap <space>/ :Unite grep:.<cr>

" Add content searching (ag.vim like)
nnoremap <Leader>s :Unite -quick-match buffer<cr>

" ###########################
" SURROUND: plugin config
" ###########################

" Disable default mappings
let g:surround_no_mappings = 1

" Set my own mappings
nmap da <Plug>Dsurround
nmap la  <Plug>Csurround
nmap lA  <Plug>CSurround
nmap ha  <Plug>Ysurround
nmap hA  <Plug>YSurround
nmap haa <Plug>Yssurround
nmap hAa <Plug>YSsurround
nmap hAA <Plug>YSsurround
xmap A   <Plug>VSurround
xmap gA  <Plug>VgSurround

" ###########################
" LATEXSUITE: plugin config
" ###########################

" REQUIRED: This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'''''"''''"""""""''""

" ###########################
" DEOPLETE: plugin config
" ###########################

let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Automatically close preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:tern_show_signature_in_pum = 1
let g:tern_show_argument_hints = 'on_move'

" ###########################
" TSUQUYOMI: plugin config
" ###########################

autocmd FileType typescript setlocal completeopt+=menu,preview

" ###########################
" VIMLATEX: plugin config
" ###########################

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'arara -v $*'
let g:Tex_IgnoredWarnings =
            \'Underfull'."\n".
            \'Overfull'."\n".
            \'specifier changed to'."\n".
            \'You have requested'."\n".
            \'Missing number, treated as zero.'."\n".
            \'There were undefined references'."\n".
            \'Citation %.%# undefined'."\n".
            \'Empty bibliography'."\n"
let g:Tex_IgnoreLevel = 8

" ###########################
" AIRLINE: plugin config
" ###########################

let g:airline_powerline_fonts = 1

" Display buffers as tabs on top
let g:airline#extensions#tabline#enabled = 1

" ###########################
" DELIMITMATE: plugin config
" ##########################

" When hitting enter between surrounding characters,
" indent correctly.
let delimitMate_expand_cr = 1

" ###########################
" UNIMPAIRED: plugin config
" ###########################

" Remap for non-US keyboard
nmap ( [
nmap ) ]
omap ( [
omap ) ]
xmap ( [
xmap ) ]

" ###########################
" SYNTASTIC: plugin config
" ###########################

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php']
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_javascript_checkers = ['jshint']
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" ###########################
" VIMMARKDOWN: personal settings
" ###########################

" Vim-markdown folding HAS to be disabled
" with plugin vim-templates : other wise, some
" folded text (eg YAML instructions for pandoc)
" can be deleted.
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" ###########################
" FUGITIVE: plugin config
" ###########################

" Force vertical split event on small screens
set diffopt+=vertical
