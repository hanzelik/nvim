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

Plug 'scrooloose/nerdtree' 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'vivien/vim-linux-coding-style'
Plug 'b4winckler/vim-objc'
Plug 'morhetz/gruvbox'
Plug 'plainfingers/black_is_the_color'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

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

"set signcolumn=yes

set pyxversion=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors/Style
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

let g:linuxsty_patterns = ["../linux", "../devel/c"]
let g:pymode_python = 'python3'

set number relativenumber

set t_Co=256

"colorscheme black_is_the_color
colorscheme gruvbox

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

noremap <silent><leader>d :NERDTreeToggle<cr>

noremap <silent><leader>t :TagbarToggle<cr>

noremap <silent><Leader>m :blast<cr>
noremap <silent><Leader>n :bNext<cr>

nnoremap <silent><Esc> :noh<Return><Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Conquer of Completion setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or us `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:go_def_mapping_enabled=0
