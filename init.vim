set rtp+=/usr/local/opt/fzf

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/MatchTagAlways'
call plug#end()

syntax on
colorscheme ayu
set termguicolors
set encoding=utf-8
set number
set ruler
set showcmd
set showmode
set hidden
set clipboard=unnamed
set mouse=a
set noswapfile
set autoread
set colorcolumn=80
set laststatus=2
set updatetime=100
let g:python_host_prog="/usr/local/bin/python3"

" Tab width (4 spaces by default for all filetypes)
set tabstop=4
set shiftwidth=4
set expandtab

" Filetype specific tab width
autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype htmldjango setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=0  " use tabs for Go

" Custom commands & functions
com Fmtjson :%!jq .

" Trim whitespace from file on write
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" Key mappings
let mapleader=","
nnoremap ; :Buffers<CR>
nnoremap <leader>d dd
nnoremap <leader>D "_dd
nnoremap <leader>t :Files<CR>

" ale settings
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['flow'],
\   'html': ['htmlhint'],
\}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_completion_enabled = 1

" vim-airline settings
let g:airline_theme='bubblegum'
let g:airline#extensions#ale#enabled = 1
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ 't'  : 'T',
  \ }

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'
