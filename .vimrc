" Config
scriptencoding utf-8

let mapleader = "\\"
let maplocalleader = "\\"
let &fillchars = 'eob: '

set autoindent
set background=dark
set backspace=start,eol,indent
set backupskip=/tmp/*
set breakindent
set cmdheight=1
set colorcolumn=80
set completeopt=menu,menuone,noselect
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set foldlevel=99
set formatoptions+=r
set gdefault
set guicursor=n-v-c-i:block
set hlsearch
set ignorecase
set incsearch
set isfname-==
set laststatus=2
set mouse=
set nobackup
set nohlsearch
set noswapfile
set nowrap
set number
set path+=**
set relativenumber
set scrolloff=8
set shell=zsh
set shiftwidth=4
set shortmess+=I
set showcmd
set smartcase
set smartindent
set smarttab
set splitbelow
set splitright
set tabstop=4
set termguicolors
set timeoutlen=300
set title
set undofile
set updatetime=250
set virtualedit=block
set wildignore+=*/node_modules/*,*/.git/*
set wildoptions=pum

execute 'set undodir=' . fnameescape(expand('~/.vim/undo'))

" Maps
nnoremap x "_x
nnoremap <silent> ss :new<CR>
nnoremap <silent> sv :vnew<CR>
nnoremap <silent> tt :new<CR>:terminal<CR>
nnoremap <silent> tv :vnew<CR>:terminal<CR>
nnoremap <Space> <C-w>w
noremap sh <C-w>h
noremap sk <C-w>k
noremap sj <C-w>j
noremap sl <C-w>l
nnoremap <C-w><Left>  <C-w><
nnoremap <C-w><Right> <C-w>>
nnoremap <C-w><Up>    <C-w>+
nnoremap <C-w><Down>  <C-w>-
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap } }zz
nnoremap { {zz
nnoremap <C-o> <C-o>zz
nnoremap `. `.zz
nnoremap G Gzz
nnoremap J mzJ`z
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
nnoremap <Leader>p "+gP
inoremap <C-h> <Esc>Bi
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>O
inoremap <C-l> <Esc>Wi
tnoremap <Esc><Esc> <C-w>N
xnoremap <silent> <Esc> <Esc>`V
nnoremap <Leader>ee oif err != nil {<CR>}<Esc>Oreturn err<Esc>
nnoremap <silent> <Leader>pp :set spell!<CR>
nnoremap <silent> <Leader>qq :enew<Bar>bd #<CR>b
nnoremap ci/ F/lct/
