set completeopt=menuone
set autoindent
set nocompatible
"tabの代わりにスペース"
set expandtab
set tabstop=4
set shiftwidth=4
set hidden
set nowrap
set incsearch
set number
set showmatch
set smarttab
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set whichwrap=b,s,<,>,[,]
set laststatus=2
set nobackup
set noswapfile
inoremap <silent> ff <ESC>
au BufNewFile,BufRead *.pde setf processing

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

if has('mouse')
  set mouse=a
endif

set laststatus=2
set showtabline=2
set t_Co=256



if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# 'dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim', s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

call dein#begin(s:dein_dir)

"プラグインマネージャー"
call dein#add('Shougo/dein.vim')

call dein#add('itchyny/lightline.vim')
call dein#add('yuttie/hydrangea-vim')
call dein#add('scrooloose/nerdtree')
call dein#add('sophacles/vim-processing')
call dein#add('Siphalor/vim-atomified')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-jedi')
call dein#add('zchee/deoplete-clang')
call dein#add('godlygeek/tabular')
"markdown用のプラグイン"
"Ctr-pでプレビューできる"
call dein#add('tpope/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
"ruby用のプラグイン"
call dein#add('tpope/vim-endwise')
call dein#add('Shougo/deoplete-rct')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('tpope/vim-fugitive')
"Vueのためのプラグイン"
call dein#add('posva/vim-vue')
"カラースキーム"
call dein#add('jdkanani/vim-material-theme')

if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-nvim-rpc')
endif

"deoplete.nvimの設定を記載"
let g:deoplete#enable_at_startup = 1

call dein#end()

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on

"カラースキーム設定"
syntax on
set t_Co=256
syntax enable
set background=dark
set termguicolors
colorscheme material-theme


"NERDTree用の設定
" Neovim起動時にNERDTreeも起動する"
autocmd VimEnter * execute 'NERDTree'
let g:nerdtree_tabs_open_on_console_startup=1
map <Leader>n <plug>NERDTreeTabsToggle<CR>

"clang補完機能の追加"
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'
let g:deoplete#sources#clang#std = {'c':'c11', 'cpp':'c++1z'}


"shellの設定"
set sh=bash

"shellのキーバインド設定"
tnoremap <silent> <ESC> <C-\><C-n>

"RubyとPythonでインデントを分ける"
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  augroup END

"" markdown用の詳細設定 {{{
   autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
   autocmd BufRead,BufNewFile *.md  set filetype=markdown
   " Need: kannokanno/previm
   nnoremap <silent> <C-p> :PrevimOpen<CR> " Ctrl-pでプレビュー
   " 自動で折りたたまないようにする
   let g:vim_markdown_folding_disabled=1
   let g:previm_enable_realtime = 1
 " }}}
let g:previm_enable_realtime = 1


"スペース + tでターミナル起動"
let mapleader = "\<Space>"
nnoremap <Leader>t :terminal<CR>
"スペース + v でターミナル起動"
nnoremap <Leader>v :vsplit<CR>
"ウインドウ移動ショートカットをswに当てる"
nnoremap fd <C-w>w
"カーソルショートカットを割当"
noremap <S-h>   ^
noremap <S-l>   $
"カーソル移動を行移動に変更"
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
"補完を使いやすく"
set wildmode=longest:full,full
"補完の選択を楽に"
inoremap <silent> jj <C-n>
inoremap <silent> kk <C-p>
"ハイライト削除"
nnoremap <silent> nn :noh<CR>

".Vueファイルのカラースキームのための設定"
autocmd FileType vue syntax sync fromstart
