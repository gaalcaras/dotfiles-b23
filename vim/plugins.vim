" BASE16: personal settings {{{

" Interface with base16-shell (theme)
if filereadable(expand("~/.dotfiles/vim/colors.vim"))
  let base16colorspace=256
  source ~/.dotfiles/vim/colors.vim
endif

" }}}

" DEOPLETE: plugin config {{{

let g:deoplete#enable_at_startup = 1

" Initialize Input Patterns
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" R Patterns
let g:deoplete#omni#input_patterns.r = '\$'

" Tex
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

" Let Tab do completion as well
inoremap <expr><tab> pumvisible() ? "\<c-p>" : "\<tab>"

set completeopt=longest,menuone

" }}}

" SURROUND: plugin config {{{

" Disable default mappings
let g:surround_no_mappings = 1

" Default mappings
nmap ds  <Plug>Dsurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround

" Special mappings for bépo layout
nmap ls  <Plug>Csurround
nmap lS  <Plug>CSurround

" Visual mode
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround

" }}}

" AIRLINE: plugin config {{{

let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_solarized'

" Display buffers as tabs on top
let g:airline#extensions#tabline#enabled = 1

" }}}

" DELIMITMATE: plugin config {{{

" When hitting enter between surrounding characters,
" indent correctly.
let delimitMate_expand_cr = 1

" }}}

" NVIM_R: plugin config {{{
let r_syntax_folding = 1

" }}}

" SYNTASTIC: plugin config {{{

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php']
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_javascript_checkers = ['standard']

" }}}

" VIMMARKDOWN: personal settings {{{

let g:vim_markdown_folding_level = 2

" }}}

" VIMTEX: personal settings {{{

let g:vimtex_fold_enabled = 1

" }}}

" FUGITIVE: plugin config {{{

" Force vertical split event on small screens
set diffopt+=vertical

" Force git english
let g:fugitive_git_executable = 'LANG=en_US git'

" }}}
