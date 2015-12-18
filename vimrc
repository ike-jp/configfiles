" =========================================================
"  MyVimrc
" + referenced:http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" + Font : Win = Myrica M, Ubuntu = Osaka
" =========================================================
" ---------------------------------------------------------
" 基本設定
" ---------------------------------------------------------
"### システム

	"タイトルをバッファ名に変更しない
	set notitle
	set shortmess+=I

	" vi互換無効
	set nocompatible

	" ターミナル接続を高速化する
	set ttyfast

	" ターミナルで256色表示を使う
	set t_Co=256

"^^^^^^^^^^^
"### ファイル

	"文字エンコード
	set encoding=UTF-8

	"ファイルフォーマット(Windows=dos, MacOS=mac)
	set fileformat=unix

	"ファイルが変更されたら自動的に読み込む
	set autoread

	"swapファイルを作るまでの時間
	set updatetime=0

	"unicodeで行末が変になる問題を解決
	set ambiwidth=double

	"バックアップディレクトリ
	"set backupdir=$HOME/.vim/backup

	"スワップファイルの置き場所
	"set directory=$HOME/.vim/backup

"^^^^^^^^^^^
"### 編集

	"タブ幅をスペース4つにする
	set shiftwidth=4

	"挿入モードで既存の文字を削除できるようにする
	set backspace=start,eol,indent

"^^^^^^^^^^^
"### 選択

"^^^^^^^^^^^
"### 検索

	"検索結果をハイライト
	set hlsearch

	"検索時に大文字と小文字を区別しない
	set ignorecase

	"検索時全て小文字なら大文字を無視
	set smartcase

	"ファイル末尾まで検索したら行頭へループ
	set wrapscan

	"/での検索時、/や?を検索するには\/、もしくは\?と書く必要がある。
	"いちいちエスケープ文字を入力するのは面倒なので自動的に\を付加する。
	noremap <expr> /
		\	getcmdtype() == '/' ? '\/' : '/'

"^^^^^^^^^^^
"### 表示

	"行番号を表示する
	set number

	"折り返さない(折り返すならwrapを指定)
	set nowrap

	"ステータスラインを常に表示(プラグインで使うので2固定)
	set laststatus=2

	"ステータスラインの文字列
	"set statusline=%=%{hahhah#get_text()}

	"編集中のファイル名を表示する
	"set title

	"入力中のコマンドを表示する
	"set showcmd

	"カーソルが何行何列目にあるかを表示する
	set ruler

	"対応する括弧を強調表示する
	set showmatch

	"行を強調表示
	set cursorline

	"列を強調表示
	"set cursorcolumn

	"タブ、行末などの不可視文字を表示する
	set list

	"リストで表示される文字のフォーマット指定~
	set listchars=tab:\|\-,trail:~

	"タブの文字数
	set tabstop	=4

	"履歴の数
	set history=1000

	"カラムの80列目に色をつける
	if (exists('+colorcolumn'))
		set colorcolumn=80
		highlight ColorColumn ctermbg=9
	endif

	"カラースキームに関わらずVimの背景も透過する
	"環境よっては端末エミュレータの透過だけでは機能しないことがあるので対策
	if !has('gui_running')
		augroup seiya
			autocmd!
			autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
			autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
			autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
			autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
			autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none
			"autocmd VimEnter,ColorScheme * highlight SpecialKey ctermbg=none ctermfg=255 "タブ部分の透過色を指定
			"+ SpecialKey : タブ、文末空白などのハイライトグループ
			"+ cterm      : カラーターミナルのハイライト方法
			"+ ctermfg    : カラーターミナルの文字色
			"+ ctermbg    : カラーターミナルの背景色
		augroup END
	endif


"^^^^^^^^^^^
"### キーマッピング

	"Help検索時に':help<Space>'と入力するのは面倒なので
	"Ctrl+hで':help<Space>'が入力されるように設定。
	noremap <C-h> :<C-u>help<Space>


"^^^^^^^^^^^
"### エイリアス

	":NTでNERDTreeを開く
	command! NT NERDTree

	":NeoBundleReloadでvimrcを読み直す
	command! NeoBundleReload source $MYVIMRC


"^^^^^^^^^^^
"### ヘルプ

	"指定したディレクトリの中にあるファイルをhelpファイルとして登録する
	"helptags $HOME/.vim/doc/


"^^^^^^^^^^^
"### QuickFix + VimGrep

	"vimgrepをしたときに自動的にQuickfixウィンドウを開く
	autocmd QuickfixCmdPost *grep* cwindow

	" *** vimgrep ***
	" :vimgrep pattern fileでファイルを跨いだ単語検索を行う
	" 直接grepしたりするよりは重いので注意。
	" vimgrepはvimと省略することができる。
	"
	" % : カレントバッファ
	" * : その階層全てのファイル
	" ** : その階層以下のファイルを再帰的に
	"
	" vimを開いたディレクトリを基準にディレクトリを指定することもできる。


" ---------------------------------------------------------
" 詳細設定
" ---------------------------------------------------------
syntax on	"必須

"### プラグインを使わないPHP構文エラーチェック

	augroup PHP_SyntaxCheck
		autocmd!
		"WatchDogsによる構文チェックは重い可能性があるので
		"単純なPHPのエラーチェックはphp -lで行う
		autocmd FileType php set makeprg=php\ -l\ %
		autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif | redraw!
	augroup END


"^^^^^^^^^^^
"### colored row-last Spaces or Tabs

	"vim-trailing-whitespaceプラグインで同じことをしているのでコメントアウト。
	"プラグインが使えない状況ならこっちを使う。

	"function! SpaceBg()
	"	highlight SpaceBg ctermbg=blue gui=underline guibg=white
	"endfunction
	"augroup SpaceBg
	"	autocmd!
	"	autocmd ColorScheme * call SpaceBg()
	"	autocmd VimEnter,WinEnter * match SpaceBg /\s$/
	"augroup END
	"call SpaceBg()


" ---------------------------------------------------------
" Neobundle plugin manager
" ---------------------------------------------------------
filetype off
if has('vim_starting')
set rtp+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

	"自動補完
	" ----------------------------
	NeoBundle 'Shougo/neocomplete'					"neocomplcacheの後継。Vin7.4以降でLua拡張があることが前提
	NeoBundle 'shawncplus/phpcomplete.vim'

	"スニペット
	"-----------------------------
	NeoBundle 'Shougo/neosnippet'					"スニペット本体。
	NeoBundle 'Shougo/neosnippet-snippets'			"NeoSnippet用のスニペット集
"	NeoBundle 'honza/vim-snippets'					"あると便利らしいスニペット集１
"	NeoBundle 'garbas/vim-snipmate'					"あると便利らしいスニペット集２

"	"コードチェッカー
"	------------------------------
	"NeoBundle 'scrooloose/syntastic.git'

	"インストールしてvimprocをビルドする
	NeoBundle "Shougo/vimproc", {
		\ 'build' : {
		\     'windows' : 'make -f make_mingw32.mak',
		\     'cygwin' : 'make -f make_cygwin.mak',
		\     'mac' : 'make -f make_mac.mak',
		\     'unix' : 'gmake -f make_unix.mak',
		\    },
		\ }
	NeoBundle "thinca/vim-quickrun"
	NeoBundle "osyo-manga/vim-watchdogs"
	NeoBundle "osyo-manga/shabadou.vim"
	NeoBundle "dannyob/quickfixstatus"				"エラー箇所の行にカーソルが当たった時に詳細を表示する
"	NeoBundle "jceb/vim-hier"						"quickfixを参照してハイライトを行う(重いのでvim-qfsignsで代用
	NeoBundle "KazuakiM/vim-qfsigns"				"エラーのラインをマーク

	"辞書
	" ----------------------------
"	NeoBundle 'koron/dicwin-vim'					"~$HOME/.vim/dictにあるファイルを辞書として使う

	"ファイル管理(ファイラ)
	" ----------------------------
	NeoBundle 'Shougo/unite.vim.git'
	NeoBundle 'Shougo/unite-outline'
	NeoBundle 'scrooloose/nerdtree'					"\:NERDTreeでツリーを表示する

	"ソースアクセス
	" ----------------------------
"	NeoBundle 'soramugi/auto-ctags.vim'				"関数ジャンプのためのctagsのタグ作成を自動で行う
	NeoBundle 'wesleyche/SrcExpl'
	NeoBundle 'vim-scripts/taglist.vim'				"定義されている関数を一覧表示する

	"カラースキーム
	" ----------------------------
	NeoBundle 'ujihisa/unite-colorscheme'			"Unite colorscheme -auto-previewでカラースキームをプレビュー
	NeoBundle 'nanotech/jellybeans.vim'
	NeoBundle 'adlawson/vim-sorcerer'
	NeoBundle 'duythinht/inori'

"	NeoBundle 'drillbits/nyan-modoki.vim'			"ステータスバーに猫が表示される
"	NeoBundle 'nathanaelkane/vim-indent-guides'
	NeoBundle 'itchyny/lightline.vim'				"リッチなステータスバー
	NeoBundle 'bronson/vim-trailing-whitespace'		"行末の半角スペースを可視化 / FixWhitespaceで行末の余計な空白を掃除できる
	NeoBundle 'severin-lemaignan/vim-minimap'		"ミニマップを表示(Python拡張が必要)

	"外部連携
	" ----------------------------
	NeoBundle 'joonty/vdebug.git'					"VDebug(dbgpクライアント)

	NeoBundle 'mattn/webapi-vim'					"ideone-vim用
	NeoBundle 'mattn/ideone-vim'					"バッファ上のコードをideoneに送って結果を受け取れる

	"オンラインジャッジ
	" ----------------------------
	NeoBundle 'eagletmt/onlinejudge-vim'			"プロコンのsubmitとかできる
"	NeoBundle 'yuratomo/w3m.vim'					"CUIのWEBブラウザ。環境にw3mをインストールする必要がある

	"その他
	" ----------------------------
	NeoBundle 'mattn/hahhah-vim'					"ハァハァできる

	"gVim用
	" ----------------------------
	if has('gui_running')
		NeoBundle 'istepura/vim-toolbar-icons-silk'	"アイコンをかっこ良くする
	endif

NeoBundleCheck
filetype plugin indent on	"これ入れないとカラースキームが適用されない
call neobundle#end()


" ---------------------------------------------------------
" plugin settings
" ---------------------------------------------------------
"### Neocomplete

	"NeocompleteはNeocomplcacheの後継。
	"Vim7.4以降でLua拡張がないと動かないので注意

	"起動時からneocompleteを有効に
	let g:neocomplete#enable_at_startup = 1

	"smart_caseを使用する
	let g:neocomplete#enable_smart_case = 1

	"Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
		\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()


"^^^^^^^^^^^
"### NERDTree

	"ファイルが指定されているときは自動的にNERDTreeを起動する。
	"そうでなければコマンドで:NERDTreeで起動。
	autocmd vimenter * if !argc() | NERDTree | endif

	"他のバッファを全て閉じたときにNERDTreeが開いていたら一緒に閉じる
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	"隠しファイルをデフォルトで表示させる
	let NERDTreeShowHidden=1

	"ブックマークを最初から表示する
	let g:NERDTreeShowBookmarks=1

	"マウス操作方法
	let g:NERDTreeMouseMode=3

	"表示を見やすくする
	"let g:NERDTreeMinimalUI=1

	"NERDTreeウィンドウに行番号を表示する
	"let NERDTreeShowLineNumbers=1


"^^^^^^^^^^^
"### Syntastic - コードチェッカ

	":SyntasticToggleで切り替え

"	set statusline+=%#warningmsg#
"	set statusline+=%{SyntasticStatuslineFlag()}
"	set statusline+=%*
"
"	"PHPで使う構文チェッカ
"	let g:syntastic_php_checkers = ['php', 'phpmd', 'phpcs']
"
"	let g:syntasitc_enable_signs = 1
"
"	"Vimを起動したディレクトリにあるruleset.xmlを見にいく
"	let g:syntastic_php_phpcs_args = '--standard=ruleset.xml'
"
"	"let g:syntastic_php_phpmd_post_args = 'phpmd_ruleset.xml'
"
"	"ファイルを開いたときにチェックする
"	"falseだと保存したときにチェックされる
"	let g:syntastic_check_on_open = 1
"
"	let g:syntastic_ignore_files = ['\.ctp$']
"	let g:syntastic_aggregate_errors = 1
"	let g:syntastic_always_populate_loc_list = 1
"	let g:syntastic_auto_loc_list = 2
"	let g:syntastic_check_on_wq = 0
"	let g:syntastic_echo_current_error = 1
"	let g:syntastic_enable_highlighting = 1
"	let g:syntastic_error_symbol = '?'
"	let g:syntastic_warning_symbol = '!'


"^^^^^^^^^^^
"### Watchdogs - コードチェッカ

if !exists("g:quickrun_config")
	let g:quickrun_config = {}
endif

	"#### Global

	"書き込み後に構文チェックを行う
	let g:watchdogs_check_BufWritePost_enable = 0

	"一定時間キー入力がなかった場合に構文チェックを行う
	let g:watchdogs_check_CursorHold_enable = 0

	"falseのとき:wq時に実行しない
	let g:watchdogs_check_BufWritePost_enable_on_wq = 0

	"vim-hierでエラー箇所がハイライトされるので:WathcdogsRun後にquickfixウィンドウを自動的に閉じる
	let g:quickrun_config['watchdogs_checker/_'] = {
		\	'outputter/quickfix/open_cmd': '',
		\	'hook/qfsigns_update/enable_exit': 1,
		\	'hook/qfsigns_update/priority_exit': 3
		\ }

	"#### PHP
	"※ruleset.xmlはvimを開いたディレクトリにあるものが使われる
	let phpcs_command = "phpcs"
	if executable(phpcs_command)
		let error_format =
			\ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
			\ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#'

		let g:quickrun_config["watchdogs_checker/phpcs"] = {
			\ "quickfix/errorformat": error_format,
			\ "command" : phpcs_command,
			\ "cmdopt" : "--report=csv --standard=ruleset.xml",
			\ "exec" : '%c %o %s:p',
			\ }

		unlet phpcs_command
		unlet error_format

		let g:quickrun_config["php/watchdogs_checker"] = {
			\ "type" : "watchdogs_checker/phpcs",
			\ }
	endif

"作成した設定をWatchDogsに
call watchdogs#setup(g:quickrun_config)

" ### Watchdogs エイリアス

	":CSで構文チェックを行う
	command! CS WatchdogsRun

	":CEでWatchDogsとハイライトを止める
	function! WatchdogsEnd()
		:WatchdogsRunSweep
		:QfsignsClear
	endfunction
	command! CE call WatchdogsEnd()

" ### Optional

	" If syntax error, cursor is moved at line setting sign.
	let g:qfsigns#AutoJump = 1

	" If syntax error, view split and cursor is moved at line setting sign.
	"let g:qfsigns#AutoJump = 2


"^^^^^^^^^^^
"### LightLine

	let g:lightline = {
		\ 'colorscheme': 'jellybeans',
		\ 'active': {
		\ 		'left': [
		\ 			['mode', 'paste'],
		\ 			['readonly', 'filename', 'modified'],
		\ 		],
		\		'right': [
		\			['lineinfo'],
		\			['percent'],
		\			['fileformat', 'fileencoding', 'filetype'],
		\			['kotori']
		\		]
		\ },
		\ 'component_function': {
		\		  'mode': 'MyMode',
		\ 		'kotori': 'KotoriForLightLine'
		\ }
	\ }

	"任意のプラグインが実行されている時、その名前をModeに表示する
	function! MyMode()
		return &ft == 'unite' ? 'Unite' :
			\ winwidth(0) > 60 ? lightline#mode() : ''
	endfunction

	"KotoriをLightLineで表示する
	function! KotoriForLightLine()
		if winwidth(0) > 70
			return '(･e･)'
		else
			return ''
		endif
	endfunction


"^^^^^^^^^^^
"### CTags

	"#### auto_cgats

		" ファイル保存の度にctagsコマンドを自動発行する
		"let g:auto_ctags=0

		" tagsファイルの名前(default:tags)
		"let g:auto_ctags_tags_name='.tags'

		" 保存場所を変更した場合の読み込むファイルの指定
		"set tags+=.tags

	"#### SrcExpl

		"SrcExpl起動時にtagsファイルをアップデートする
		let g:SrcExpl_UpdateTags=1

	"#### taglist

		"Ctagsコマンドの場所
"		let Tlist_Ctags_Cmd="$HOME/local/bin/ctags"

		"自動ハイライト
		"let Tlist_Auto_Hightlight_Tag=1

		"現在表示中のファイルのみのタグしか表示しない
"		let Tlist_Show_One_File=1

		"右側にtag listのウィンドウを表示
"		let Tlist_Use_Right_Window=1

		"taglistのウィンドウだけならVimを閉じる
"		let Tlist_Exit_OnlyWindow=1


"^^^^^^^^^^^
"### VDebug

	let g:vdebug_options = {}
	let g:vdebug_options["port"]=9000
	" vdebugの各種breakのマーカーなどの設定がutf-8じゃないと
	" 認識できない文字列をデフォルトで設定しているらしい
	let g:vdebug_force_ascii=1

	"デバッグ待ち受け時間の指定
	let g:vdebug_options["timeout"]=120

	" IDEキーにxdebugが指定されているセッションのみ受け付ける
	" 起動時に任意のIDEキーを設定したい場合は
	" 	vim -c "let g:vdebug_options['ide_key']='piyo'"
	" のようにすればいい。
	let g:vdebug_options["ide_key"]="xdebug"

	" IDEキーを書き換える用の関数
	" 呼び出し方:call SetIdeKey("key_name")
	function! SetIdeKey(key)
		let g:vdebug_options["ide_key"]=a:key
	endfunction


"^^^^^^^^^^^
"### WebAPI+Ideone

	let g:ideone_open_buffer_after_post=1


"^^^^^^^^^^^
"### Nyan_Modoki settings

	"set statusline=%F%m%r%h%w[%{&ff}]%=%{g:NyanModoki()}(%l,%c)[%P]
	"let g:nyan_modoki_select_cat_face_number=2
	"let g:nyan_modoki_animation_enabled=1
	"set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][%3l,%3c,%3p]


"^^^^^^^^^^^
"### vim-indent-guides settings

	"vimを立ち上げたときに自動的にindent_guideをオンにする
	"let g:indent_guides_enable_on_vim_startup=1
	"hi IndentGuidesOdd ctermbg=black
	"hi IndentGuidesEven ctermbg=darkgrey

"^^^^^^^^^^^
"### Online Judge

	"vimからOnline Judgeを楽しむためのプラグイン
	let g:onlinegudge_account = {
		\ 'poj' : {'user': 'example', 'pass': 'password'},
		\ 'aoj' : {},
		\ }

"^^^^^^^^^^^
"### color scheme

	"正しく表示されないときは
	"export TERM=xterm-256colorを.bashrcなどに記述する必要がある。
	colorscheme jellybeans
"	set bg=dark


filetype on		"ファイルタイプを元に戻す
