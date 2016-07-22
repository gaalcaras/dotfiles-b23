" ###########################
" SOLARIZED: colorscheme config
" ###########################

set background=dark
colorscheme solarized

" Underline spell check results
hi clear SpellBad
hi SpellBad cterm=underline

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
nmap da  <Plug>Dsurround
nmap la  <Plug>Csurround
nmap lA  <Plug>CSurround
nmap ha  <Plug>Ysurround
nmap hA  <Plug>YSurround
nmap haa <Plug>Yssurround
nmap hAa <Plug>YSsurround
nmap hAA <Plug>YSsurround

" Visual mode
xmap A   <Plug>VSurround
xmap gA  <Plug>VgSurround

" ###########################
" DEOPLETE: plugin config
" ###########################

let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#omni#input_patterns.r = '(\$|(data)?\.)'
let g:deoplete#omni#input_patterns.r = '[a-zA-Z_]\w*?'

let g:deoplete#omni#input_patterns.tex = '\\(?:'
        \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
        \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
        \ . '|hyperref\s*\[[^]]*'
        \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
        \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
        \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
\ .')'

" inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"


" Automatically close preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:tern_show_signature_in_pum = 1
let g:tern_show_argument_hints = 'on_move'

" ###########################
" TSUQUYOMI: plugin config
" ###########################

autocmd FileType typescript setlocal completeopt+=menu,preview

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
" NVim-R: plugin config
" ###########################
" let R_path = "/bin/R"

" ###########################
" FUGITIVE: plugin config
" ###########################

" Force vertical split event on small screens
set diffopt+=vertical

" Force git english
let g:fugitive_git_executable = 'LANG=en_US git'

" ###########################
" TEMPLATE: plugin config
" ###########################

let g:templates_directory = ['$HOME/.dotfiles/vim/templates']
let g:templates_global_name_prefix = 'template'
