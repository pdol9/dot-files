"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set path+=../inc,../include,../tests,./src,./srcs

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><space> :nohlsearch<CR>
inoremap  <Esc>
nnoremap <space> :

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>

let g:mappings_enabled = 1

function! ToggleMappings()
    if g:mappings_enabled
        imap 1 !
        imap 2 @
        imap 3 #
        imap 4 $
        imap 5 %
        imap 6 ^
        imap 7 &
        imap 8 *
        imap 9 (
        imap 0 )
        imap - _
        imap = +
        let g:mappings_enabled = 0
    else
        iunmap 1
        iunmap 2
        iunmap 3
        iunmap 4
        iunmap 5
        iunmap 6
        iunmap 7
        iunmap 8
        iunmap 0
        iunmap -
        iunmap =
        let g:mappings_enabled = 1
    endif
endfunction

inoremap <F9> <C-O>:call ToggleMappings()<CR>

" toggle on non-printable-chars
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬
map <F2> :set invlist<CR>

" terminal
nnoremap <silent> <F4> :bel term<CR>
set autochdir

" run python script
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" insert date
nnoremap <f6> :r!date "+\%Y-\%m-\%d \%H:\%M:\%S" <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set foldmethod=syntax
"set foldlevel=2
nnoremap ' zR
nnoremap " zM
nnoremap zz zA
nnoremap <leader><leader> za

" Define a function to set the custom highlight
function! SetCustomHighlight()
    highlight Folded ctermbg=black ctermfg=cyan guibg=#000000 guifg=#ffffff
endfunction

" Call the function when the ColorScheme event is triggered
augroup SetCustomHighlightGroup
    autocmd!
    autocmd ColorScheme * call SetCustomHighlight()
augroup END

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

" tags
set tags=./tags,tags;/

" Define a shortcut to generate tags for the project
command! -nargs=0 GenerateTags !ctags -R --exclude=.git --exclude=build
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <Esc>/ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List plugins 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'mhinz/vim-startify'
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'slint-ui/vim-slint'
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'tribela/vim-transparent'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins' settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" iced-vim
set runtimepath-=$HOME/.vim
set runtimepath-=$HOME/.vim/after
set packpath=/tmp/vim-iced-test
let g:iced_enable_default_key_mappings = v:true

" Configure ALE to use GNU compilers for C and C++
let g:ale_linters = {
\   'c': ['gcc'],
\   'cpp': ['g++'],
\ }

" Optionally, configure ALE to use GNU compilers for fixing
let g:ale_fixers = {
\   'c': ['gcc'],
\   'cpp': ['g++'],
\ }

" Enable trim_whitespace and remove_trailing_lines for all file types
let g:ale_fixers = {
\   '*': ['trim_whitespace', 'remove_trailing_lines'],
\ }

" ALE uses existing Makefile
let g:ale_c_parse_makefile = 1

" syntax highlighting
autocmd BufEnter *.slint :setlocal filetype=slint

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"colorscheme zenburn

colorscheme molokai
autocmd VimEnter * nested
\   if &ft ==# 'c' || &ft ==# 'cpp' | colorscheme koehler |
\   elseif &ft ==? 'clj' | colorscheme industry |
\   elseif &ft ==# 'rust' | colorscheme ron |
\   else | colorscheme delek |
\   endif

autocmd VimEnter *.clj :colo industry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-autosave
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FocusLost * silent! w
autocmd FileType clj set autowrite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unused settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set autowrite					" enable if needed
"autocmd FileType clj colorscheme industry
