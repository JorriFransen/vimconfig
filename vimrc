
set nocompatible
filetype plugin indent on
syntax on
set backspace=start,eol,indent
set hidden
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set laststatus=2
set encoding=utf-8
set ttimeoutlen=1
set timeoutlen=500
set number
set cursorline
set clipboard=unnamedplus

" set cmdheight=2
set mouse=a
set splitbelow
set splitright

set path=.,,*
set wildignore=*.o,*~

let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.vim/vimrc"

set backupdir=$HOME/.cache/vim/backup//
set directory^=$HOME/.cache/vim/swap//

if has('gui_running')
    set guioptions-=T
    set guioptions-=m
endif

set guifont=Hack\ 11

if (has("nvim"))
    " GuiFont Hack:h11
    let $nvim_tui_enable_true_color=1
    autocmd TermOpen * startinsert
endif

if (has("termguicolors"))
    set termguicolors
endif

set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

" Treat Zodiac/.zdc files as cpp files
autocmd BufNewFile,BufRead *.zdc set syntax=cpp | set filetype=cpp

set completeopt=longest,menuone

call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'justinmk/vim-sneak'

    Plug 'skywind3000/asyncrun.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'derekwyatt/vim-fswitch'
    Plug 'preservim/nerdcommenter'
    Plug 'Raimondi/delimitMate'
    Plug 'vim-scripts/nextval'
    Plug 'tpope/vim-fugitive'
    Plug 'liuchengxu/vim-which-key'

    Plug 'rakr/vim-one'
    Plug 'morhetz/gruvbox'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'jacoborus/tender.vim'
    Plug 'romainl/Apprentice'
    Plug 'nanotech/jellybeans.vim'
    Plug 'ajh17/Spacegray.vim'
    Plug 'christianchiarulli/nvcode.vim'
call plug#end()

let g:sneak#label = 1

set background=dark
" colorscheme one
colorscheme nvcode

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" fswitch setup
au! BufEnter *.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = '../include/*/'
au! BufEnter *.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = '../../source/'


set t_Co=256
set noshowmode

" let g:airline_theme='deus'
let g:airline_theme='nvcode'
let g:airline_powerline_fonts=1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_extensions = ['branch', 'tabline', 'whitespace']
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z', 'warning', 'error']]

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Status-line
" set statusline=
" set statusline+=%#StatusLine#
" set statusline+=\ %M "Modified? (display + when modified)
" set statusline+=\ %y "File type
" set statusline+=\ %r "Read only
" set statusline+=\ %F "File name (full path)

" set statusline+=%= "Right align
" set statusline+=%#DiffText#

" set statusline+=\ %l/%L
" set statusline+=\ %c
" set statusline+=\ %p%%
" set statusline+=\ [%n]\

" Different cursor for insert/normal mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

function! Open_Terminal()
    if (has("nvim"))
        exec "tabe | terminal"
    else
        exec "tab terminal"
    endif
endfunc

inoremap jj <esc>

let mapleader = "\<Space>"
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Tab navigation
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
noremap <leader>th :tabp<CR>
noremap <leader>tp :tabp<CR>
noremap <leader>tl :tabn<CR>
noremap <leader>tn :tabn<CR>
noremap <leader>tq :tabc<CR>

tmap <C-h> <C-\><C-n>:tabp<CR>
tmap <C-l> <C-\><C-n>:tabn<CR>

" Window navigation
noremap <leader>wq :wincmd q<CR>
noremap <leader>wh :wincmd h<CR>
noremap <leader>wl :wincmd l<CR>
noremap <leader>wj :wincmd j<CR>
noremap <leader>wk :wincmd k<CR>
noremap <leader>ws :wincmd s <CR> :wincmd j<CR> :GFiles<CR>
noremap <leader>wv :wincmd v <CR> :wincmd l<CR> :GFiles<CR>

nnoremap <F5> :call Compile()<CR>
nnoremap <leader>cc :call Compile()<CR>
inoremap <F5> <esc>: call Compile()<CR>
" inoremap <leader>cc <esc>: call Compile()<CR>

noremap <leader>cd :call quickfix#toggle()<CR>
noremap <leader>en :cn<CR>
noremap <leader>ep :cp<CR>
noremap ,ga :w<CR>:FSHere<CR>
noremap <C-p> :GFiles<CR>
noremap <leader>pp :GFiles<CR>
noremap <leader>pf :FZF<CR>
noremap <leader>f :find
noremap <leader>bs :buffer
noremap <leader>bb :Buffers<CR>

noremap <leader>gg :Rg<CR>
noremap <leader>gs :vert Gstatus<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gd :Git diff<CR>
noremap <leader>gp :!git push<CR>


map <leader>; <plug>NERDCommenterToggle
"
" Move lines up or down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Sneak
nmap <leader>m <Plug>Sneak_s
nmap <leader>M <Plug>Sneak_S

" Delimate additions
inoremap {<CR> {<CR>}<Esc>O

map <leader>T :call Open_Terminal()<CR>
map <leader>C :tabe $RC<CR>
map <leader>R :w<CR>:so %<CR>

set exrc
set secure
