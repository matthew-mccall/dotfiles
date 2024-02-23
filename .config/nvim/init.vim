filetype plugin indent on
syntax on

set tabstop=4
set shiftwidth=4
set expandtab

set number
set breakindent
set formatoptions=l
set lbr

set termguicolors

set exrc

let g:ale_completion_enabled=1
let g:ale_c_clangformat_use_local_file=1

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arzg/vim-colors-xcode'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'onsails/lspkind.nvim'

Plug 'lervag/vimtex'
Plug 'micangl/cmp-vimtex'
Plug 'dense-analysis/ale'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'm4xshen/autoclose.nvim'

call plug#end()

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_min_count = 2

let g:vimtex_view_method = 'skim'

source ~/.config/nvim/cmp.lua
