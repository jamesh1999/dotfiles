" Plugins
" =======
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/Colorizer'
Plug 'sheerun/vim-polyglot'
Plug 'jamesh1999/nord-vim'
call plug#end()

" Colour setup
" ============
set t_Co=256
set notermguicolors
colorscheme nord

" Settings
" ========
set hidden
set hlsearch
set ignorecase
set smartcase
set incsearch
set magic " Better regex
set number
set relativenumber
set noswapfile
set splitbelow " Better split directions
set splitright " "
set visualbell
set wildmenu
set noruler " For airline
set noshowmode " "
set clipboard=unnamedplus
set shiftwidth=4
set tabstop=4


" Keybinds
" ========
imap jj <Esc>

" Prevent arrow keys
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" Better matching
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Split navigation
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
inoremap <C-H> <C-W>h
inoremap <C-L> <C-W>l
inoremap <C-J> <C-W>j
inoremap <C-K> <C-W>k

" Commands
command! W w !sudo tee % > /dev/null " :W sudo save
cnoreabbrev qw wq

" Plugin configuration
" ====================
"
let g:airline_powerline_fonts = 1
let g:python_highlight_indent_errors = 1
let g:python_highlight_space_errors = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_no_boost = 1
