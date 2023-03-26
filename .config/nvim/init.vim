" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

set encoding=UTF-8
call plug#begin()

"""
""" Neovim
"""
"" let g:python3_host_prog = substitute(system('asdf which python'),'\n$','','''')

"""
""" Defaults
"""
source $HOME/.config/nvim/ultimate_vimrc_basic.vim
Plug 'tpope/vim-sensible'

"""
""" Language Server (prefer for linting)
"""
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
\ 'python': ['pyls'],
\ }

" "'elixir': ['~/.language-servers/elixir-ls-release/language_server.sh'],

nnoremap <silent> zc :call LanguageClient_contextMenu()<CR>
nnoremap <silent> zh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> zd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> zr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> ze :call LanguageClient#textDocument_references()<CR> nnoremap <silent> zi :call LanguageClient#textDocument_implementation()<CR> nnoremap <silent> zt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> zs :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> zg :call LanguageClient#debugInfo()<CR>

"""
""" ALE (prefer for fixing)
"""
Plug 'w0rp/ale'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

let g:ale_elixir_elixir_ls_release = '$HOME/.language-servers/elixir-ls-release'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ocaml': ['merlin'],
\   'reason': ['merlin'],
\   'elixir': ['elixir-ls', 'credo'],
\   'haskell': ['hdevtools']
\}

let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_ocaml_ocamlformat_options = '-p compact --let-open auto --sequence-style terminator'
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'python': ['yapf'],
\   'html': ['prettier'],
\   'vue': ['prettier', 'eslint'],
\   'elixir': ['mix_format'],
\   'reason': ['refmt'],
\   'ocaml': ['ocamlformat'],
\   'haskell': ['hfmt'],
\   'rust': ['rustfmt'],
\   'c': ['clang-format'],
\}

"""
""" NERDtree
"""
Plug 'scrooloose/nerdtree'
map <F3> :NERDTreeFind <CR>
let g:NERDTreeShowHidden=1

" Start NERDTree with vim . not vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close Vim if only NERDTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'Xuyuanp/nerdtree-git-plugin'

"""
""" Git
"""
"Plug 'tpope/vim-fugitive'  " git commands
Plug 'airblade/vim-gitgutter'  " git diff in gutter

"""
""" Editor Improvements
"""
Plug 'tpope/vim-surround'  " properly deal with surrounding objects, like quotes
Plug 'tpope/vim-commentary'  " comments
Plug 'justinmk/vim-sneak'  " press s to navigate to a two letter combination
Plug 'junegunn/goyo.vim'  " minimalist mode
Plug 'kana/vim-textobj-user'  " custom text objects
Plug 'whatyouhide/vim-textobj-xmlattr'  " more xml text objects
Plug 'chaoren/vim-wordmotion'  " respect underscores and camelcase in motion
Plug 'tpope/vim-abolish'  " useful word processing
Plug 'Raimondi/delimitMate'  " autocomplete ([' etc
let g:delimitMate_expand_cr = 1
Plug 'wellle/visual-split.vim'  " split the screen for some selected text
Plug 'wellle/targets.vim'  " more text objects

"""
""" Alignment
"""
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:easy_align_ignore_groups = []

"""
""" Autocomplete
"""
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Use tab to cycle through completions
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Merlin
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
"let g:deoplete#omni#input_patterns = {}
"let g:deoplete#omni#input_patterns.ocaml = '[.\w]+'
"let g:deoplete#omni#input_patterns.reason = '[.\w]+'
"let g:deoplete#file#enable_buffer_path = 1

" Elm
" Plug 'pbogut/deoplete-elm'
" let g:deoplete#omni#functions = {}
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['file', 'neosnippet']
" let g:deoplete#omni#functions.elm = ['elm#Complete']
" let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
" let g:deoplete#sources.elm = ['omni'] + g:deoplete#sources._

"""
""" Status bar
"""
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"let g:airline_powerline_fonts = 0
"let g:airline_theme='onedark'

"""
""" Search
"""
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

" Plug 'ryanoasis/vim-devicons'


"""
""" Lang Support
"""
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'JamshedVesuna/vim-markdown-preview'

"""
""" Latex Support
"""
"Plug 'lervag/vimtex'

"let g:tex_flavor = 'latex'

" Viewer options: One may configure the viewer either by specifying a built-in
" " viewer method:
" let g:vimtex_view_method = 'zathura'

" " Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" " VimTeX uses latexmk as the default compiler backend. If you use it, which is
" " strongly recommended, you probably don't need to configure anything. If you
" " want another compiler backend, you can change it as follows. The list of
" " supported backends and further explanation is provided in the documentation,
" " see ":help vimtex-compiler".
" let g:vimtex_compiler_method = 'latexrun'

" " Most VimTeX mappings rely on localleader and this can be changed with the
" " following line. The default is usually fine and is the symbol "\".
" let maplocalleader = ","

"""
""" Misc Plugins
"""
" ctags bar
Plug 'majutsushi/tagbar'
nmap <C-T> :TagbarToggle<CR>

" fuzzy finder
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude=test'

" resize windows easier
Plug 'simeji/winresizer'
let g:winresizer_start_key = '<C-V>'

" html emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" thesaurus
Plug 'ron89/thesaurus_query.vim'
let g:tq_enabled_backends=["woxikon_de","jeck_ru","thesaurus_com","openoffice_en","mthesaur_txt"]
let g:tq_python_version = 3

" floobits
" Plug 'Floobits/floobits-vim'


"""
""" Theme
"""
Plug 'connorholyday/vim-snazzy'

"""
""" Indentation
"""
set autoindent
" automatic indent detection
Plug 'tpope/vim-sleuth'
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

call plug#end()
colorscheme snazzy

"""
""" FASD
"""
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

"""
""" Terminal shortcuts
"""
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

"""
""" WordProcessor mode
"""
func! WordProcessor() " movement changes map j gj map k gk
  " formatting text
  setlocal formatoptions=1
  set formatprg=par
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  " spelling and thesaurus
  setlocal spell spelllang=en_us
  set thesaurus+=$HOME/.vim/thesaurus/mthesaur.txt
  " complete+=s makes autocompletion search the thesaurus
  set complete+=s
endfu
com! WP call WordProcessor()

"""
""" Misc
"""

" up and down move visually
map j gj
map k gk

" fix paste formatting
set nopaste

" line numbering mode
set number "relativenumber
nmap <F2> :so ~/.config/nvim/init.vim<CR><CR><CR>
nmap <leader>n :tabnew

" copy to system keyboard
set clipboard=unnamedplus

" delete without yanking
noremap gd "_d
noremap gx "_x

" ctags?
let $TMPDIR = $HOME"/temp"

" Strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Scroll
:map <ScrollWheelUp> <C-Y>
:map <S-ScrollWheelUp> <C-U>
:map <ScrollWheelDown> <C-E>
:map <S-ScrollWheelDown> <C-D>

" ?
cabbr <expr> %% expand('%:p:h')

" select paste
nnoremap <expr> gV    "`[".getregtype(v:register)[0]."`]"

" redo
map U :redo<CR>

" stop column width from increasing from lint indicators
set signcolumn=yes:1

" Zoom
noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
