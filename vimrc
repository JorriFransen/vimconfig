
set nocompatible
filetype plugin indent on
syntax on
set backspace=start,eol,indent
set hidden
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

set mouse=a
"Fix scrolling down in st
if &term =~ '^st\($\|-\)'
  set ttymouse=sgr
endif

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

let &t_SI = "\033[5 q"
let &t_SR = "\033[3 q"
let &t_EI = "\033[2 q"

if (has("nvim"))
    let $nvim_tui_enable_true_color=1
    autocmd TermOpen * startinsert
endif

if (has("termguicolors"))
    set termguicolors
endif

set guifont=FiraCode\ Nerd\ Font\ Mono:h11
" set guifont=FiraMono\ Nerd\ Font:h11
" set guifont=BitstreamVeraSansMono\ Nerd\ Font:h11

set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

" Treat Zodiac/.zdc files as cpp files
autocmd BufNewFile,BufRead *.zdc set filetype=zdc | set syntax=cpp
autocmd FileType zdc let b:coc_suggest_disable = 1

" .compute files are hlsl files
autocmd BufNewFile,BufRead *.compute set filetype=hlsl | set syntax=hlsl

" set completeopt=noinsert,menuone

let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'justinmk/vim-sneak'

    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    " Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'derekwyatt/vim-fswitch'
    Plug 'preservim/nerdcommenter'
    Plug 'Raimondi/delimitMate'
    Plug 'vim-scripts/nextval'
    Plug 'tpope/vim-fugitive'
    Plug 'beyondmarc/hlsl.vim'

    Plug 'arcticicestudio/nord-vim'
    Plug 'rakr/vim-one'
    Plug 'morhetz/gruvbox'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'jacoborus/tender.vim'
    Plug 'romainl/Apprentice'
    Plug 'nanotech/jellybeans.vim'
    Plug 'ajh17/Spacegray.vim'
    Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
call plug#end()

let g:OmniSharp_server_use_mono = 1

source $HOME/.config/nvim/plug-config/coc.vim

" Fix coc/delimate binding
imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>delimitMateCR"

" lua << EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained",
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = {},  -- list of language that will be disabled
"   },
"   indent = {
"     enabled = false,
"   },
"   incremental_selection = {
"     enabled = false,
"   },
" }
" EOF

let g:sneak#label = 1

set background=dark
" colorscheme one
colorscheme nvcode

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'zdc': { 'left': '//','right': '' } }

" fswitch setup
au! BufEnter *.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = '../include/*/'
au! BufEnter *.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = '../../source/'


set t_Co=256
set noshowmode

let g:airline_theme='deus'
" let g:airline_theme='onedark'
" let g:airline_theme='nvcode'
let g:airline_powerline_fonts=1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_extensions = ['branch', 'tabline', 'whitespace', 'coc']
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z', 'warning', 'error']]

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Different cursor for insert/normal mode
" let &t_SI = "\e[5 q"
" let &t_EI = "\e[2 q"

" optional reset cursor on start:
" au!
" augroup myCmds
" autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END

function! Open_Terminal()
    if (has("nvim"))
        exec "tabe | terminal"
    else
        exec "tab terminal"
    endif
endfunc

inoremap jj <esc>

" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

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
noremap <leader>bs :buffer
noremap <leader>bb :Buffers<CR>

noremap <leader>gg :Rg<CR>
noremap <leader>gs :vert Gstatus<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gl :Glog<CR>
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

let g:Hexokinase_highlighters = [ 'background' ]

set exrc
set secure

" Neovim terminal colors
if has("nvim")
  let g:terminal_color_0 =  "#151515"
  let g:terminal_color_1 =  "#AC4142"
  let g:terminal_color_2 =  "#90A959"
  let g:terminal_color_3 =  "#F4BF75"
  let g:terminal_color_4 =  "#6A9FB5"
  let g:terminal_color_5 =  "#AA759F"
  let g:terminal_color_6 =  "#75B5AA"
  let g:terminal_color_7 =  "#D0D0D0"
  let g:terminal_color_8 =  "#505050"
  let g:terminal_color_9 =  "#AC4142"
  let g:terminal_color_10 = "#90A959"
  let g:terminal_color_11 = "#F4BF75"
  let g:terminal_color_12 = "#6A9FB5"
  let g:terminal_color_13 = "#AA759F"
  let g:terminal_color_14 = "#75B5AA"
  let g:terminal_color_15 = "#F5F5F5"
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_5
  if &background == "light"
    let g:terminal_color_background = g:terminal_color_7
    let g:terminal_color_foreground = g:terminal_color_2
  endif
elseif has("terminal")
  let g:terminal_ansi_colors = [
        \ "#151515",
        \ "#AC4142",
        \ "#90A959",
        \ "#F4BF75",
        \ "#6A9FB5",
        \ "#AA759F",
        \ "#75B5AA",
        \ "#D0D0D0",
        \ "#505050",
        \ "#AC4142",
        \ "#90A959",
        \ "#F4BF75",
        \ "#6A9FB5",
        \ "#AA759F",
        \ "#75B5AA",
        \ "#F5F5F5",
        \ ]
endif
