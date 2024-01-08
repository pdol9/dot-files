"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set number relativenumber
set clipboard=unnamedplus
set backspace=indent,eol,start

set updatetime=300
set encoding=utf-8
scriptencoding utf-8

set hlsearch
set wildmenu
set wildignore=*.jpg,*.png,*.gif,*.pdf,*.pyc,*.flv,*.img
set wildmode=list:longest
set showcmd
set signcolumn=no

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><space> :nohlsearch<CR>
inoremap ii <Esc>
nnoremap <space> :

inoremap 9 ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>

inoremap 1 !
inoremap 2 @
inoremap 3 #
inoremap 4 $
inoremap 5 %
inoremap 6 ^
inoremap 7 &
inoremap 8 *
inoremap 0 )
inoremap - _

inoremap ! 1
inoremap @ 2
inoremap # 3
inoremap $ 4
inoremap % 5
inoremap ^ 6
inoremap & 7
inoremap * 8
inoremap ( 9
inoremap ) 0
inoremap _ -

" toggle on non-printable-chars
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬
map <F2> :set invlist<CR>

" terminal
nnoremap <silent> <F4> :bel term<CR>
set autochdir

" run python script
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" insert date
nnoremap <f6> :r!date "+\%F" <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set foldmethod=indent
"augroup filetype_vim
"    autocmd!
"    autocmd FileType vim setlocal foldmethod=marker
"augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab, indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
filetype plugin indent on
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set noexpandtab
set cindent

" syntax highlighting
""autocmd BufRead, BufNewFile *.s set filetype=nasm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List plugins 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'guns/vim-sexp',    {'for': 'clojure'}
"Plug 'clojure-vim/clojure.vim'
"Plug 'preservim/nerdtree'
"Plug 'tribela/vim-transparent'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'ghifarit53/tokyonight-vim'
call plug#end()

" iced-vim
set runtimepath-=$HOME/.vim
set runtimepath-=$HOME/.vim/after
set packpath=/tmp/vim-iced-test
let g:iced_enable_default_key_mappings = v:true

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" default schemes
"colorscheme murphy
"colorscheme desert
"colorscheme delek
"colorscheme darkblue
"colorscheme default
"colorscheme blue
"colorscheme elflord
"colorscheme koehler
"colorscheme ron
"colorscheme pablo
"colorscheme slate
"colorscheme torte
"colorscheme industry

"colorscheme wal
"colorscheme zenburn

"" tokio night theme
"set termguicolors
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight

:autocmd BufEnter,FileType *
\   if &ft ==# 'c' || &ft ==# 'cpp' | colorscheme koehler |
\   elseif &ft ==? 'clj' | colorscheme industry |
\   else | colorscheme delek |
\   endif

autocmd VimEnter *.clj :colo industry
"autocmd FileType clj colorscheme industry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-autosave
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FocusLost * silent! w
autocmd FileType clj set autowrite
"set autowrite							" enable if needed
"autocmd VimLeave						" saving at exiting

" Save once per minute if there are changes
" let g:autosave_seconds = 60
" au BufRead,BufNewFile * let b:start_time=localtime()
" au CursorHold * silent! call UpdateFile()
" function! UpdateFile()
"   if ((localtime() - b:start_time) >= g:autosave_seconds)
"     update
"     let b:start_time=localtime()
"   endif
" endfunction
" au BufWritePre * let b:start_time=localtime()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unused settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"autocmd VimEnter * NERDTree
"inoremap <C-a>{ {<Cr><Cr>}<Up>
"map <silent> <F3> :NERDTreeToggle %:p:h<CR>

