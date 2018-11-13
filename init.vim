set rtp+=/usr/local/opt/fzf
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/MatchTagAlways'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'zxqfl/tabnine-vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'elmcast/elm-vim'
call plug#end()

" Basic settings
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
set colorcolumn=80
set laststatus=2
set updatetime=100

" Key mappings
let mapleader=","
nnoremap ; :Buffers<CR>
nnoremap <leader>d dd
nnoremap <leader>D "_dd
nnoremap <leader>t :Files<CR>
nnoremap <leader>; :NERDTreeToggle<CR>
nnoremap <leader>h :noh<CR>

" Use ripgrep for fzf
let $FZF_DEFAULT_COMMAND = 'rg --files'

" Paths for neovim Python providers
let g:python_host_prog=$HOME."/.neovim-pyenv/py2/bin/python"
let g:python3_host_prog=$HOME."/.neovim-pyenv/py3/bin/python"

" Tab width (4 spaces by default for all filetypes)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Filetype specific tab width
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=0  " use tabs for Go

" Trim whitespace from file on write
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" Code folding
set foldlevelstart=1
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_docstring_preview = 1

" Format json with `jq`
com Fmtjson :%!jq .

" vim-json settings
let g:vim_json_syntax_conceal = 0

" deoplete settings
"let g:deoplete#enable_at_startup = 1

" jedi-vim settings
set completeopt-=preview " don't open preview window
let g:jedi#completions_enabled = 1
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#documentation_command = "K"
let g:jedi#goto_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#completions_command = ""

" indentLine settings
let g:indentLine_char = '┆'

" ale settings
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
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

" Workaround for paste issue
" https://github.com/neovim/neovim/issues/7994
au InsertLeave * set nopaste
