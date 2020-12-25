set rtp+=/usr/local/opt/fzf
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/MatchTagAlways'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'davidhalter/jedi-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'StanAngeloff/php.vim'
Plug 'rust-lang/rust.vim'
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
set signcolumn=yes
set cmdheight=3

" Key mappings
let mapleader=","
nnoremap ; :Buffers<CR>
nnoremap <leader>d dd
nnoremap <leader>D "_dd
nnoremap <leader>t :Files<CR>
nnoremap <leader>; :NERDTreeToggle<CR>
nnoremap <leader>h :noh<CR>

" Recursively search files with ripgrep.
nnoremap <leader>s :Rg<CR>

" Paths for neovim Python providers
let g:python_host_prog=$HOME."/.pyenv/versions/nvim-py2-provider/bin/python"
let g:python3_host_prog=$HOME."/.pyenv/versions/nvim-py3-provider/bin/python"

" Assorted plugin settings
let $FZF_DEFAULT_COMMAND = 'rg --files' " Use ripgrep for fzf.
let g:vim_json_syntax_conceal = 0
let g:indentLine_char = '┆'
let NERDSpaceDelims=1
let g:gutentags_generate_on_write=0

" Tab width (4 spaces by default for all filetypes)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Filetype specific tab width
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript.tsx setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=0  " use tabs for Go

" Commands
" Format json with `jq`
command Fmtjson :%!jq '.'

" Trim whitespace from file on write
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" Linting/completions
set completeopt-=preview " Don't open preview window.
let g:ale_completion_enabled = 0 " Don't use ale's completion.
let g:nvim_typescript#diagnostics_enable=0 " Use ale for linting TS.
let g:deoplete#enable_at_startup = 1

let g:ale_echo_msg_format = '%linter% :: %s'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters_explicit = 1 " Only run linters defined in `ale_linters`.
let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\   'javascript': ['eslint'],
\   'typescript': ['tsserver'],
\   'typescriptreact': ['tsserver'],
\   'typescript.tsx': ['tsserver'],
\   'php': ['phpcs', 'phpstan'],
\   'go': ['golint', 'govet'],
\   'rust': ['cargo', 'analyzer'],
\}
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\ }

let g:ale_php_phpstan_executable = "vendor/bin/phpstan"
let g:ale_php_phpstan_level = "7"

let g:jedi#completions_enabled = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#documentation_command = "K"
let g:jedi#goto_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#completions_command = ""

" Uncomment to auto-run prettier on save.
" vim-prettier
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" vim-airline
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
