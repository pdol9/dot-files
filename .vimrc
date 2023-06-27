"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set number relativenumber
set clipboard=unnamedplus
set nowrap
set scrolloff=999
set showcmd
set hlsearch
set wildmenu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader><space> :nohlsearch<CR>
inoremap ii <Esc>
nnoremap X y$
nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>

nnoremap <C-m> :bel term<Esc>
map <silent> <F3> :NERDTreeToggle %:p:h<CR>

" toggle on non-printable-chars
map <F2> :set invlist<CR>
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬

" Define status line colors for different modes
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ %{get(b:,'gitsigns_status','')}\ [LINE=%l/%L]\ [COL=%c]\ [%p%%]\ %P
highlight Normal guibg=black guifg=white
highlight Command guibg=red guifg=white

" Map the F5 key to run a Python script inside Vim.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
set smartindent
set expandtab
set autoindent
set tabstop=4
set shiftwidth=4

" apply the indentation to certain languages using tabs instead of space
set cindent
autocmd FileType c,cpp,asm,as,s  setlocal noexpandtab
"autocmd FileType c,cpp,asm,as,s  setlocal shiftwidth=4

" set syntax highlighting
autocmd BufRead,BufNewFile *.s set filetype=asm

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
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors schemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"colorscheme wal
"colorscheme murphy
"colorscheme desert
"colorscheme delek

" set following theme as default
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" set zenburn
"colors zenburn

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cursorline
hi CursorLine cterm=NONE ctermbg=242
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-autosave
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save on lost focus/exit
":set autowrite                 " enable if needed
autocmd FocusLost * silent! w
" to save at exit -> VimLeave

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

"set autochdir
"autocmd VimEnter * NERDTree

