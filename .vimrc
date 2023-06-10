"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable compatibility with vi which can cause unexpected issues. 
set nocompatible
set smartindent

set number relativenumber				" Display line numbers
set clipboard=unnamedplus				" Copy/paste between vim and other programs.
syntax enable

" remove highlight matches
nnoremap <leader><space> :nohlsearch<CR>

" visual space indicators
"set list
"set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»
"map <F2> :set invlist<CR>

" toggle on non-printable-chars
map <F2> :set invlist<CR>
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬
"
" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=999

" Show partial command you type in the last line of the screen.
set showcmd

" search highlighting
set hlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Type ii to exit insert mode
inoremap ii <Esc>
"inoremap <C-j> <Esc>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter O/o will open a new line below/above the current one.
nnoremap o o<esc>
nnoremap O O<esc>

" Yank from cursor to the end of line.
nnoremap Y y$

" Map <C-a> to open "embedded terminal" in Normal mode
nnoremap <C-a> :bel term<Esc>

" Define status line colors for different modes
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ %{get(b:,'gitsigns_status','')}\ [LINE=%l/%L]\ [COL=%c]\ [%p%%]\ %P
highlight Normal guibg=black guifg=white
highlight Command guibg=red guifg=white

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set autoindent
set tabstop=2
set shiftwidth=2

" apply the indentation to certain languages using tabs instead of space
autocmd FileType c,cpp,asm,as,s  setlocal noexpandtab
autocmd FileType c,cpp,asm,as,s  setlocal shiftwidth=2

" set syntax highlighting
autocmd BufRead,BufNewFile *.s set filetype=asm

" Enable auto completion menu after pressing TAB.
set wildmenu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Map the F5 key to run a Python script inside Vim.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

call plug#begin()
" List your plugins here
Plug 'preservim/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'dense-analysis/ale'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors schemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
" colorscheme wal
" colorscheme murphy

" set following theme as default
"set termguicolors
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight

" set zenburn
colors zenburn

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

