set nocompatible
filetype off
set t_Co=256
call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug '~/my-prototype-plugin'
Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'tpope/vim-fugitive'
Plug 'elzr/vim-json'
Plug 'dyng/ctrlsf.vim'
Plug 'airblade/vim-rooter'
Plug 'tomasiser/vim-code-dark'
call plug#end()
colors codedark
let g:airline_theme = 'codedark'
set shiftwidth=4
set tabstop=4
set expandtab
filetype plugin on
filetype indent on
syntax on
set nu
set autochdir
nmap <leader>l :set list!<CR>
set mouse=a
set autoread
let NERDTreeQuitOnOpen = 1
set completeopt=menu
set linebreak
autocmd Filetype html,ruby,javascript,yml,yaml,json,haskell,ejs,htmldjango setlocal ts=2 sts=2 sw=2
set noswapfile
set wildignore+=*.pyc
if &term =~ '256color'
  set t_ut=
endif
let g:ycm_autoclose_preview_window_after_completion=1
set enc=utf-8
set fileencodings=ucs-bom,utf8,prc
set fileencoding=utf-8
set nofoldenable
filetype plugin indent on
let g:python2_host_prog = 'E:\Program_Files\nvimpy2\Scripts\python.exe'
let g:python3_host_prog = 'E:\Program_Files\venv\Scripts\python.exe'
let g:black_virtualenv = 'E:\Program_Files\venv'
let g:acp_enableAtStartup = 0
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabe'
      \ }
nnoremap <c-p> :FZF<cr>
nnoremap <c-f> :Rg<cr>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
