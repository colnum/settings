" Setting for plugin start --------------------------------------------------
" install dir 
" dein によってプラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein installation check
if &runtimepath !~# '/dein.vim'
 if !isdirectory(s:dein_repo_dir)
 execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
 endif
 execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" begin settings
if dein#load_state(s:dein_dir)
 call dein#begin(s:dein_dir)

 " .toml file
 " dein.toml dein_lazy.toml を読み込むディレクトリ
 let g:rc_dir = expand('~/.vim/dein')
 let s:toml = g:rc_dir . '/dein.toml'
 " dein_lazy.toml を使わない場合はこの行をコメントアウト
 let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

 " read toml and cache
 call dein#load_toml(s:toml, {'lazy': 0})
 " dein_lazy.toml を使わない場合は下行をコメントアウト
 " call dein#load_toml(s:lazy_toml, {'lazy': 1})

 call dein#add('scrooloose/nerdtree')
 " Add or remove your plugins here like this:
 call dein#add('vim-airline/vim-airline')
 call dein#add('vim-airline/vim-airline-themes')
 call dein#add('ryanoasis/vim-devicons')
 " end settings
 call dein#end()
 call dein#save_state()
endif

" plugin installation check
if dein#check_install()
 call dein#install()
endif

"NERDTree
"隠しファイルを表示させる
let NERDTreeShowHidden = 1
"ツリーの表示幅を固定(半角文字数)
let NERDTreeWinSize = 26
"[Ctrl + e]でNERDTreeを開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>
"エイリアスも設定
:command Tr NERDTree

"インデントの深さを可視化
let g:indent_guides_enable_on_vim_startup = 0
"[Ctrl + l]でNERDTreeを開く
nnoremap <silent><C-l> :IndentGuidesToggle<CR>
"可視化を無効にしたいファイルタイプがある時は指定
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
"色を変更する(偶数行と奇数行で色分け設定)
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=white ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black ctermbg=darkgray
"可視化領域のサイズを変更
let g:indent_guides_guide_size = 1
"可視化を行う階層を指定
let g:indent_guides_start_level = 1

let g:airline_theme = 'deus'               " テーマの指定
"let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用
let g:airline#extensions#tabline#left_sep = '|'
" Setting for pluging end --------------------------------------------------


" Setting for basic start --------------------------------------------------
"文字コードをUTF-8に設定
set encoding=utf-8
"全角の記号が半角幅にされるのを防ぐ
set ambiwidth=double
"バックアップファイルを作らない
set nobackup
"スワップファイルを作らない
set noswapfile
"バッファが編集中でもその他のファイルを開けるように
set hidden
"入力中のコマンドをステータスに表示する
set showcmd
"行番号を表示
set number
"yankしたテキストをクリップボードに格納する
set clipboard=unnamed,autoselect
"backspaceで改行を超えて前の行まで戻る
set backspace=indent,eol,start

"インデントはスマートインデント
set smartindent
"インデントはオートインデント
set autoindent
"ステータスラインを常に表示
set laststatus=2
"括弧入力時の対応する括弧を表示
set showmatch
"行末の一文字先までカーソルを移動できるようにする
set virtualedit=onemore
"行番号をハイライト
set cursorline
"列番号をハイライト
"set cursorcolumn
"cursorlineの色をクリア
"hi clear CursorLine

"ファイル名を表示
set statusline=%F
"変更チェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウィンドウなら[Preview]と表示
set statusline+=%w
"これ以降は右寄せ表示
set statusline+=%=
"File Encording
set statusline+=[ENC=%{&fileencoding}]
"現在行数/全体行数
set statusline+=[LOW=%l/%L]
"ステータスラインを常に表示(0:表示しない、1:2つ以上のウィンドウがある時だけ表示)
set laststatus=2

"Tab系
"不可視文字を可視化(タブが「--」と表示される)
set list
"listcharsの設定は一行にまとめないと一番最後のしか読み込まない
set listchars=tab:>-,trail:>,nbsp:>
"Tab文字を半角スペースにする
set expandtab
"Tab文字を半角スペースにしない
"set noexpandtab
"行頭以外でのTab文字の表示幅
set tabstop=4
"行頭でのTab文字の表示幅
set shiftwidth=4

"見た目系
" --- molokai theme ---
" autocmd ColorScheme * highlight Comment ctermfg=144 guifg=#008800
" colorscheme molokai
" syntax on
" let g:molokai_original=1
" let g:rehash256=1
" set background=dark

" --- iceberg theme ---
autocmd ColorScheme * highlight Comment ctermfg=144 guifg=#008800
colorscheme iceberg
syntax on
let g:iceberg_original=1
let g:rehash256=1
set background=dark

" Setting for basic end --------------------------------------------------
