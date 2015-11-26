" =========================================================
"  My gVimrc
" + referenced: http://teppeis.hatenablog.com/entry/20080705/1215262928
" +             http://www.jonki.net/entry/20140406/1396773150
" +             http://ylgbk.hatenablog.com/entry/2015/01/07/120000
" =========================================================
"
" memo:
"  + 詳細は「:h guioptions」を参照
"  + =の前後にスペースを入れると正しく認識しない
"

"カラースキーム
colorscheme jellybeans

"フォント設定
set guifont=Myrica_M:h11

"ウィンドウ透過
autocmd FocusGained * set transparency=220

"ツールバーを非表示
"set guioptions-=T

"左右のスクロールバーを非表示
"set guioptions-=r
"set guioptions-=R
set guioptions-=l
set guioptions-=L

"水平スクロールバーを非表示
set guioptions-=b

"BEEP音を鳴らさない
set vb t_vb=
