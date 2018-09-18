source /home/anton/.config/nvim/ultimate_vimrc_basic.vim
"source .config/nvim/ultimate_vimrc_extended.vim

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
map <F3> :NERDTreeFind <CR>
let g:NERDTreeShowHidden=1

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'scrooloose/syntastic'
"Plug 'altercation/vim-colors-solarized'
"Plug 'scrooloose/nerdcommenter'
"Plug 'tpope/vim-commentary'
Plug 'tyru/caw.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'w0rp/ale'
let g:ale_fix_on_save = 1
"let g:ale_open_list = 1

let g:ale_linters = {
\   'python': ['pylint'],
\   'javascript': ['eslint'],
\   'ocaml': ['merlin']
\}
" let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'python': ['yapf'],
\   'html': ['prettier'],
\   'vue': ['eslint']
\}



Plug 'mhinz/vim-signify'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#omni#input_patterns = {}
"Merlin
:set rtp+=<SHARE_DIR>/merlin/vim
let g:deoplete#omni#input_patterns.ocaml = '[.\w]+'
let g:deoplete#omni#input_patterns.reason = '[.\w]+'
"call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
"call deoplete#custom#option('auto_complete_delay', 100)
""call deoplete#custom#var('omni', 'input_patterns', {
"    \ 'ocaml': ['.*', '[.\w]+'],
"    \})

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'

" Text objects
Plug 'kana/vim-textobj-user'
"Plug 'michaeljsmith/vim-indent-object'
"Plug 'vim-scripts/argtextobj.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'whatyouhide/vim-textobj-xmlattr'
"Plug 'inside/vim-textobj-jsxattr'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:easy_align_ignore_groups = []

Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
"inoremap {<cr> {<cr>}<c-o>O<tab>
"inoremap [<cr> [<cr>]<c-o>O<tab>
"inoremap (<cr> (<cr>)<c-o>O<tab>

Plug 'editorconfig/editorconfig-vim'
"Plug 'terryma/vim-expand-region'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'wellle/visual-split.vim'
"Plug 'maxbrunsfeld/vim-yankstack'

Plug 'wellle/targets.vim'
"Plug 'kien/ctrlp.vim'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
nmap <C-T> :TagbarToggle<CR>

Plug 'dyng/ctrlsf.vim'
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_regex_pattern = 0
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_position = 'right'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
"Plug 'Shougo/denite.nvim'

Plug 'ryanoasis/vim-devicons'
"if !exists('syntax_on')
	"syntax reset
"endif

Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"Plug 'kien/ctrlp.vim'

Plug 'vim-scripts/django.vim'

"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
"let g:session_autosave = 'yes'
"let g:session_autoload = 'yes'

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<C-V>'

Plug 'tpope/vim-abolish'

Plug 'jreybert/vimagit'
Plug 'tpope/vim-sleuth'
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
"Plug 'hdima/python-syntax'
let g:python_highlight_all = 1

"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

"Plug 'danielepiccone/vim-css-indent'

"Plug 'hail2u/vim-css3-syntax'
Plug 'sheerun/vim-polyglot'

"Plug 'Glench/Vim-Jinja2-Syntax'

"augroup VimCSS3Syntax
" autocmd!
"
"  autocmd FileType css setlocal iskeyword+=-
"augroup END

"Plug 'othree/xml.vim'
"Plug 'lumiliet/vim-twig'

Plug 'airblade/vim-gitgutter'
"let g:gitgutter_highlight_lines = 1
"let g:gitgutter_override_sign_column_highlight = 0

"Plug 'arcticicestudio/nord-vim'
"Plug 'joshdick/onedark.vim'
"Plug 'morhetz/gruvbox'
"Plug 'chriskempson/base16-vim'
Plug 'connorholyday/vim-snazzy'
Plug 'mhartington/oceanic-next'

Plug 'Quramy/tsuquyomi'
Plug 'posva/vim-vue'

Plug 'ron89/thesaurus_query.vim'
let g:tq_enabled_backends=["woxikon_de","jeck_ru","thesaurus_com","openoffice_en","mthesaur_txt"]
let g:tq_python_version = 2


Plug 'Vigemus/iron.nvim'
call plug#end()


" theme
" set background=dark
" colorscheme solarized

" custom
set nopaste
set encoding=UTF-8
set number relativenumber
nmap <F2> :so ~/.config/nvim/init.vim<CR><CR><CR>
nmap <leader>n :tabnew

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Fix css (somehow)
set indentexpr=""
:autocmd BufEnter * :setlocal indentexpr=""

" Start NERDTree with vim . not vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close Vim if only NERDTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='oceanicnext'

"let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme astromouse
colorscheme snazzy


" FASD
function! s:fasd_update() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    call jobstart(['fasd', '-A', expand('%:p')])
  endif
endfunction
augroup fasd
  autocmd!
  autocmd BufWinEnter,BufFilePost * call s:fasd_update()
augroup END
command! FASD call fzf#run(fzf#wrap({'source': 'fasd -al', 'options': '--no-sort --tac --tiebreak=index'}))
nnoremap <silent> <Leader>e :FASD<CR>

let $TMPDIR = $HOME"/temp"

"Strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

"Scroll
:map <ScrollWheelUp> <C-Y>
:map <S-ScrollWheelUp> <C-U>
:map <ScrollWheelDown> <C-E>
:map <S-ScrollWheelDown> <C-D>


cabbr <expr> %% expand('%:p:h')

:tnoremap <Esc> <C-\><C-n>
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

func! WordProcessor()
  " movement changes
  map j gj
  map k gk
  " formatting text
  setlocal formatoptions=1
  set formatprg=par
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  " spelling and thesaurus
  setlocal spell spelllang=en_us
  set thesaurus+=/home/anton/.vim/thesaurus/mthesaur.txt
  " complete+=s makes autocompletion search the thesaurus
  set complete+=s
endfu
com! WP call WordProcessor()

" terminal
set modifiable
