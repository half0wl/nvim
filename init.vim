set rtp+=/usr/local/opt/fzf
call plug#begin('~/.config/nvim/plugged')
" Tooling
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'github/copilot.vim'
" Editor helpers
Plug 'scrooloose/nerdcommenter'
Plug 'valloric/MatchTagAlways'
Plug 'Yggdroot/indentLine'
" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
" Language-specific tooling & plugins
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Languages (syntaxes, ...)
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

" -----------------------------------------------------------------------------
" Basics
" -----------------------------------------------------------------------------
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

" Tab width (4 spaces by default for all filetypes)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Folding
" @TODO Needs additional testing. Fold-by-indent is probably easiest to
" start with.
" @NOTE Use `nofoldenable` to skip folding new files on open.
" set foldmethod=indent
" set foldlevel=1
" set foldnestmax=10

" Filetype specific tab width
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript.tsx setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=2 expandtab
autocmd FileType json syntax match Comment +\/\/.\+$+  " jsonc
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=0  " use tabs for Go

" Paths for neovim Python providers
let g:python_host_prog=$HOME."/.pyenv/versions/nvim-py2-provider/bin/python"
let g:python3_host_prog=$HOME."/.pyenv/versions/nvim-py3-provider/bin/python"

" Workaround for paste issue
" https://github.com/neovim/neovim/issues/7994
au InsertLeave * set nopaste

" -----------------------------------------------------------------------------
" Keymaps
" -----------------------------------------------------------------------------
let mapleader=","
nnoremap ; :Buffers<CR>
nnoremap <leader>d dd
nnoremap <leader>D "_dd
nnoremap <leader>t :Files<CR>
nnoremap <leader>; :NERDTreeToggle<CR>
nnoremap <leader>h :noh<CR>
nnoremap <leader>s :Rg<CR>
nnoremap <leader>c :CocCommand<CR>
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

" -----------------------------------------------------------------------------
" Plugin configuration
" -----------------------------------------------------------------------------
let $FZF_DEFAULT_COMMAND = 'rg --files'
let g:vim_json_syntax_conceal = 0
let g:indentLine_char = '┆'
let NERDSpaceDelims=1

" Linting/completions
let g:ale_completion_enabled = 0  " Disable ale completion
let g:ale_echo_msg_format = '%linter% :: %s'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters_explicit = 1  " Only run linters defined in `ale_linters`
let g:ale_linters = {
\   'php': ['phpcs', 'phpstan'],
\   'go': ['golint', 'govet'],
\   'rust': ['cargo', 'analyzer'],
\}
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\   'php': ['phpcbf'],
\ }

" PHPStan
let g:ale_php_phpstan_executable = "vendor/bin/phpstan"
let g:ale_php_phpstan_level = "8"

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

" Coc (coc-metals)
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>

" -----------------------------------------------------------------------------
" Definitions
" -----------------------------------------------------------------------------

" Trim whitespace from file on write
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" K (shift+k) show documentation in preview window
fun! s:ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfun

" -----------------------------------------------------------------------------
" Commands
" -----------------------------------------------------------------------------
command Fmtjson :%!jq '.'
autocmd BufWritePre * :call TrimWhitespace()

" Auto-run `prettier` on save. Uncomment to enable:
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
