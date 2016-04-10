
" Installing vim-plug
let plug_installed = 0
let plug_config = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(plug_config)
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim
        \ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let plug_installed = 1
endif

call plug#begin()

" Visual
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

" Behaviour
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'benekastah/neomake'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator'

" Utils
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'keith/investigate.vim'
Plug 'marcsolanadal/vim-simple-notes'

" Web development
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'

call plug#end()

" Installing modules the first time nvim is opened
if plug_installed == 1
    :PlugInstall
endif

syntax on
filetype plugin indent on

colorscheme gruvbox
set background=dark

" behaviour
set scrolloff=5
set relativenumber
set splitbelow
set splitright
set hlsearch
set incsearch
set ignorecase
set nobackup
set nowritebackup
set noswapfile
set visualbell
set noerrorbells
set expandtab
set shiftwidth=4
set softtabstop=4

" visual
set list                 " Show tabs, trail spaces and invisible spaces
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪          " Character showed when line break

set spelllang=en_us

let g:lightline = { 'colorscheme': 'wombat' }

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" --------------------------------------------------------------
" Mappings
" --------------------------------------------------------------

let mapleader = ","

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P<Paste>

" Splits creation
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>

" Quick access to configuration files
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>eb :e ~/.bashrc<CR>

" Buffer management
nnoremap <Esc><Esc> :close<CR>
tnoremap <Esc><Esc> <C-\><C-n>:close<CR>
nnoremap <leader>w :w!<CR>

" Navigation
nnoremap <leader>c :term<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>

" Improved window movement
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

if exists('$TMUX')
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
else
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
endif

" --------------------------------------------------------------
" Features
" --------------------------------------------------------------

" The silver searcher with CtrlP
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[/\](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
nnoremap <leader>f :CtrlP .<CR>
nnoremap <silent> \ :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
"nnoremap <silent> | :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" --------------------------------------------------------------
" Auto Commands
" --------------------------------------------------------------
if has('autocmd')

    " Set spelling for comments
    if has('spell')
        au BufRead,BufNewFile *.md setlocal spell
        au FileType gitcommit setlocal spell
    endif

    " Trim whitespaces from all filetypes
    "au BufWritePre * :%s/\s\+$//e

    " README files are markdown
    au BufNewFile,BufRead README set filetype=markdown

    " Reaload init.vim on save
    au! BufWritePost init.vim source %

    " Controls the behaviour when entring/leaving the terminal
    au BufWinEnter,WinEnter term://* startinsert
    au BufLeave term://* stopinsert

    " Disable auto commenting in general
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

endif

" TODO: Neovim thread open cmus on start if flag is enabled
" TODO: Browse tmux collections
let g:cmus_playing = 0
function! CmusToogle()
    if g:cmus_playing
        silent exec "!cmus-remote --play"
        let g:cmus_playing = 1
    else
        silent exec "!cmus-remote --pause"
        let g:cmus_playing = 0
    endif
endfunction
nnoremap <silent> <leader><space> :call CmusToogle()<CR>
nnoremap <silent> <leader>cn :silent exec "!cmus-remote --next"<CR>
nnoremap <silent> <leader>cp :silent exec "!cmus-remote --prev"<CR>

