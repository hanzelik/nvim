"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Matthew Hanzelik
"
" About: My personal Vim configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug call
call plug#begin('~/.config/nvim/plugged')

" Vim enhancements
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'norcalli/nvim-colorizer.lua'

" GUI enhancements
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree' 

" Set linux kernel coding styling
Plug 'vivien/vim-linux-coding-style'

" Vim themes
Plug 'ishan9299/modus-theme-vim'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Language support
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
Plug 'cespare/vim-toml'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'simrat39/rust-tools.nvim'

" Fuzzy finder stuff
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'

call plug#end()

let g:cssColorVimDoNotMessMyUpdatetime = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set title

set history=500

set so=7

set encoding=utf8

filetype plugin on
filetype indent on

set autoread

set wildmenu

set ruler

set hid

" Make the backspace work like an actual backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase

set smartcase

set hlsearch

set incsearch

set showmatch

set mat=2

set hidden

" Disable bells/visuals from ringing
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set updatetime=300

set shortmess+=c

set signcolumn=yes

set pyxversion=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors/Style
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

let g:linuxsty_patterns = ["~/repos/linux", "~/devel/c"]
let g:pymode_python = 'python3'

set number relativenumber

set t_Co=256

"let g:lightline = {'colorscheme': 'modus_vivendi'}
colorscheme modus-vivendi

hi Normal ctermbg=NONE

set nobackup
set nowb
set noswapfile

set smarttab

set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai
set si
set wrap

set noshowmode

set cursorline

if (has("termguicolors"))
	set termguicolors
endif

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" A fair amount taken from https://sharksforarms.dev/posts/neovim-rust/ guide

lua << EOF
-- Enable colorizer
require'colorizer'.setup()

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- local cmp object
local cmp = require'cmp'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

local opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		hover_with_actions = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	server = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy"
				},
			}
		}
	},
}

cmp.setup({
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
})

nvim_lsp.clangd.setup {
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes"
	},
	filetypes = {"c", "cpp"},
}

-- TS/JS
nvim_lsp.tsserver.setup {
	on_attach=on_attach,
	filetypes = {"typescript", "typescriptreact", "typescript.tsx", "javascript"},
}

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require('rust-tools').setup(opts)

EOF

let g:go_def_mapping_enabled=0

" Rust specific stuff
autocmd FileType rust nnoremap <buffer> <cr> :w<cr>:RustFmt<cr>:w<cr>
au FileType rust set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
au FileType rust set colorcolumn=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

map <C-J> <C-W>j<C-W><cr>
map <C-K> <C-W>k<C-W><cr>
map <C-H> <C-W>h<C-W><cr>
map <C-L> <C-W>l<C-W><cr>

nmap <leader>; :Buffers<CR>
nmap <leader>w :w<CR>

noremap <silent><leader>d :NERDTreeToggle<cr>

noremap <silent><leader>t :TagbarToggle<cr>

noremap <silent><Leader>m :blast<cr>
noremap <silent><Leader>n :bNext<cr>

nnoremap <silent><Esc> :noh<Return><Esc>

" Lets <Tab> and <S-Tab> be used to navigate popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" Use <Tab> as the trigger key
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Show diagnostic popup on cursor hold
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
"autocmd CursorHold * lua vim.lsp.diagnostic.open_float()
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false})

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Enable type inlay hints
"autocmd CursorMoved,InsertLeave,TabEnter,BufWritePost *
"\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
