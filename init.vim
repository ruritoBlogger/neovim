set encoding=utf-8
scriptencoding utf-8

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
      \ 'colorscheme': 'gotham256',
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
set ttimeoutlen=10


if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# 'dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim'.s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

call dein#begin(s:dein_dir)

"プラグインマネージャー"
call dein#add('Shougo/dein.vim')

call dein#add('vim-airline/vim-airline')
call dein#add('yuttie/hydrangea-vim')
call dein#add('scrooloose/nerdtree')
call dein#add('sophacles/vim-processing')
call dein#add('Siphalor/vim-atomified')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-jedi')
call dein#add('zchee/deoplete-clang')
call dein#add('godlygeek/tabular')
call dein#add('plasticboy/vim-markdown')
call dein#add('lervag/vimtex')
call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' })
call dein#add('sheerun/vim-polyglot')
call dein#add('dense-analysis/ale')
call dein#add('vim-jp/vimdoc-ja')
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
"テンプレート用"
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
"kotlin用"
call dein#add('udalov/kotlin-vim')
"コメントアウト用"
call dein#add('kazukazuinaina/commentout.vim')
"git用"
call dein#add('lambdalisue/gina.vim')
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-nvim-rpc')
endif

"deoplete.nvimの設定を記載"
let g:deoplete#enable_at_startup = 1

"airlineの設定"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
call dein#end()

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on

"カラースキーム設定"
syntax enable
set background=dark
if has('termguicolors')
    set termguicolors
endif
colorscheme gotham256

if executable('ctags')
    set tags=./tags;
endif

"NERDTree用の設定
" Neovim起動時にNERDTreeも起動する"
"autocmd VimEnter * execute 'NERDTree'
"let g:nerdtree_tabs_open_on_console_startup=1
"map <Leader>n <plug>NERDTreeTabsToggle<CR>

"clang補完機能の追加"
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'
let g:deoplete#sources#clang#std = {'c':'c11', 'cpp':'c++1z'}

"shellのキーバインド設定"
tnoremap <silent> <ESC> <C-\><C-n>

"RubyとPythonでインデントを分ける"
augroup fileTypeIndent
    autocmd!
    autocmd Filetype *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd FileType *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
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
nnoremap <Leader>n :split<CR>
"ウインドウ移動ショートカットをfdに当てる"
nnoremap fd <C-w>w
"タブ移動ショートカットをswに当てる"
nnoremap gg gt
"タブ生成ショートカットをnewに当てる"
nnoremap :new :tabnew
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
nnoremap <silent> mm :noh<CR>

".Vueファイルのカラースキームのための設定"
autocmd FileType vue syntax sync fromstart
"latexの環境"
let g:latex_latexmk_options = '-pdfdvi'

"テンプレート用"

"Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/template/'

" 関数を定義
function Indent()
  let save_cursor = getcurpos()
  execute "normal " . "gg=G"
  call setpos('.', save_cursor)
endfunction
command -nargs=0 Indent call Indent()

call gina#custom#command#option('status', '--opener', 'vsplit')
call gina#custom#command#option('diff', '--opener', 'vsplit')
call gina#custom#command#option('log', '--opener', 'vsplit')
"setting update command"
function PluginUpdate()
  if exists('*dein#update()')
    call dein#update()
  endif
endfunction
command -nargs=0 PluginUpdate call PluginUpdate()
