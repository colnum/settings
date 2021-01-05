# Setting for Python and pip

## install

Pythonとpipの本体をインストールする
```
sudo apt install python3-dev python3-pip
python3 -V
pip3 -V
```

他で使う依存ライブラリ
```
sudo apt install libssl-dev libffi-dev
```

## Libraries

## matplotlibの日本語化設定
下記サイトを参考にした
https://qiita.com/yniji/items/3fac25c2ffa316990d0c

matplotlibで日本語を扱う場合の問題点を以下に示す。
 - matplotlibでは既定のフォントがDejaVu Serifになっており、日本語は豆腐になってしまう。英語のフォントの足りない部分を日本語フォントにリンクする機能がないため、日本語を表示しようと思ったら、日本語フォントを指定する必要がある。
 - 日本語用フォントのほとんどがttcフォントファイルであるが、従来matplotlibではttcフォントファイルに対応していなかった。matplotlib ver 3.1.0から、ttcフォントファイルに対応したので、PCだと新しくフォントをインストールする必要がなくなったが、次のような問題がまだ残っている。
     - TTCファイルには複数のフォントを含めることができるが、そのコレクションの最初のフォントだけをサポートしている。
     - pdfやpsのフォント埋め込みには対応していない。
     - フォントのweightを正しく取得できていない場合があって、予期していない太さのフォントが表示される場合がある。

以下、対応方法のメモを示す。

### フォントを準備する
利用可能なフォントの一覧は以下で表示できる。
```
python3
>>> import matplotlib.font_manager as fm
>>> fm.findSystemFonts()
```

また、フォントリストのキャッシュファイルが、ホームディレクトリの.matplotlibまたは.cache/matplotlibに、fontlist-v310.jsonというようにバージョンをつけた名前で作成される。

そこには利用可能なフォントの一覧があって、フォント名の項目もあるので、設定の時はその名前を使うと良い。

なお、フォントリストがキャッシュされているので、新しくフォントをインストールした時は、新しいフォントを認識させるためにそのキャッシュファイルを一度削除してやる必要がある。

```
sudo apt install fonts-ipafont fonts-ipaexfont
# Ubuntu18.04
sudo apt install fonts-noto-cjk
# Ubuntu16.06
sudo apt install fonts-takao-pgothic fonts-takao-mincho
```

### 日本語フォントを使う設定をする
今回はスクリプトの最初でフォントの変更を宣言する方式を採用する。

```
from matplotlib import rcParams
rcParams['font.family'] = 'sans-serif'
rcParams['font.sans-serif'] = ['Hiragino Maru Gothic Pro', 'Yu Gothic', 'Meirio', 'Takao', 'IPAexGothic', 'IPAPGothic', 'VL PGothic', 'Noto Sans CJK JP']
```