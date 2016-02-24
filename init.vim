
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
Plug 'wikitopian/hardmode'

" Web development
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'

" Objective-C
"Bundle "b4winckler/vim-objc"

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

let g:netrw_liststyle=3

" visual
set list                 " Show tabs, trail spaces and invisible spaces
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪          " Character showed when line break

let g:lightline = {
            \ 'colorscheme': 'wombat'
            \ }

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

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
nnoremap <leader>ez :e ~/.zshrc<CR>

" Navigation
nnoremap <leader>c :term<CR>
"nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>

" Improved window movement
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
nnoremap  <leader>f :CtrlP .<CR>
nnoremap \ :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Set spelling for comments
if has('spell')
    au BufRead,BufNewFile *.md setlocal spell
    au FileType gitcommit setlocal spell
endif

" --------------------------------------------------------------
" Nevernote
" --------------------------------------------------------------

let g:NNRootPath="~/Dropbox/nevernote/notes"

function! GetInput(prompt)
    let curline = getline('.')
    call inputsave()
    let input = input(a:prompt)
    call inputrestore()
    return input
endfunction

function! CreateMarkdown()
    let filename = GetInput('Filename: ')
    if filename
        silent execute "!" . "mkdir " . g:NNRootPath
        silent execute "vs " . g:NNRootPath . "/" . filename . ".md"
    endif
endfunction

function! SelectMarkdown()
    let notes = {}
    let files = split(globpath(g:NNRootPath, '*.md'), '\n')
    let num = 0
    for i in files
        let num += 1
        let notes[num] = i
        echo num . " - " . fnamemodify(i, ":t:r")
    endfor
    let noteNum = GetInput('Note: ')
    if noteNum
        silent execute "vs " . notes[noteNum]
    endif
endfunction

nnoremap <leader>nn :call CreateMarkdown()<CR>
nnoremap <leader>nl :call SelectMarkdown()<CR>

" --------------------------------------------------------------

" Switching buffers with numbers
function! BufferSwitch()
    buffers
    let curline = getline('.')
    call inputsave()
    let num = input('Buffer num: ')
    call inputrestore()
    execute "buffer " . num
endfunction
nnoremap <leader>b :call BufferSwitch("~/Dropbox/nevernote/notes")<CR>

" --------------------------------------------------------------
" Autocommands
" --------------------------------------------------------------
if has('autocmd')
    au BufWritePre * :%s/\s\+$//e
    au FileType js,java setlocal comments-=:// comments+=f://
    au BufNewFile,BufRead README set filetype=markdown
    au! BufWritePost init.vim source %
endif
