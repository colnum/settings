# Setting for Bash

## .bash_profileと.bashrcの使い分け
### .bash_profile
.bash_profileはログイン時にのみ実行される。
つまりbashをログインシェルに設定しており、ユーザがコンピュータにログインした際や、sshでログインした際に実行される。
そのため、ログインシェルがzshなどに設定されている場合、bashコマンドなどでbashを起動した時、.bash_profileは読み込まれない。

しかし、環境変数の設定などはログインシェルで定義されているものがプロセス間で受け継がれるので、ログイン時に何かのシェルで設定されていれば大丈夫である。

.bash_profileには環境変数の設定(export hoge~)のような、プロセス間で共通の設定を記述しておくと良い。

### .bashrc
.bashrcは対話モードのbashを起動する時に毎回実行される。
そのため、他のシェルの子プロセスとして対話モードでbashが呼ばれた時なども実行される必要がある設定を記述する。

具体的には
 - 環境変数ではない変数の定義(exportしない変数)
 - エイリアスの定義
 - シェル関数の定義
 - コマンドライン補完の設定
といった、ログインシェルでない場合に対話モードで起動された時にも設定したい内容を記述しておく。

特に他のシェルでは使用しない、bashでしか使わないものを記述する。

### ~/.profileとは
デフォルトのシェルはBourne shell(いわゆる/bin/sh)と呼ばれ、「ログインシェル」として起動するときに~/.profileを読みこむ。(Bourneは作者の名前)

 - ```~/.profile```
     - ログイン時にそのセッション全体に適用するものを記述する
     - シェルの種類に依存しないものを記述する(環境変数(PATH)など)
     - ログインシェルで使うものはここに記述すべき
     - GUIアプリでも使うものやbin/shで使うものはここに記述すべき
 - ```~/.bashrc```
     - bashでしか使わないものを記述する(エイリアスやシェルオプションなど)
     - 対話モードのシェルとしてのbashで使用するものは全てここに書く(スクリプト実行は関係ない)
     - ここでは何も(標準出力や標準エラーへ)出力してはならない。出力する必要があるなら```/dev/null```などに捨てるようにする。
 - ```~/.bash_profile```
     - ```~/.profile```と同じに使えるが、bashのみで有効
     - 余計なものは極力書かない
     - ```~/.profile```があれば読みこむ、```~/.bashrc```があれば読みこむ、の順に各ファイルを読みこむよう設定する。

###　ログインシェルとは
 > A login shell is one whose first character of argument zero is a -, or one started with the --login option.
 > ログインシェルとは、引数0（argv[0]）の1文字目が「-」である場合、または--loginつきで起動された場合をいう。

ログインシェルとしての起動方法(起動時実行スクリプト:.bash_profile)
ssh user@host
su -
bash --login
tmux 新規ウィンドウ

### 対話的シェルとは
 > An interactive shell is one started without non-option arguments and without the -c option whose standard input and error are both connected to
 > terminals (as determined by isatty(3)), or one started with the -i option.
 > 対話的シェルとは、オプションでない引数（例：bash hoge.sh）がなく、-cもなく、標準入力と標準エラー出力が端末に接続されている場合か、または-iつきで起動された場合をいう。

bash が対話的なログインシェルとして起動されるか、--loginオプション付きの非対話的シェルとして起動されると、/etc/profileファイルが存在すれば、bashはまずここからコマンドを読み込んで実行します。
このファイルを読んだ後、 bashは~/.bash_profile, ~/.bash_login, ~/.profileをこの順番で探します。
bashは、この中で最初に見つかり、かつ読み込みが可能であるファイルからコマンドを読み込んで実行します。
--noprofileオプションを使ってシェルを起動すれば、この動作を行わないようにできます。

つまりbash_profileを見つけて読んでしまえば、.profileも.bashrcも読み込まなくなってしまうので、bash_profile内で、他に読んで欲しい設定ファイルを指定し、読みに行くようにしなければならない。

インタラクティブシェルとしての起動方法(起動時実行スクリプト：.bashrc)
su [user]
bash

### 問題：全部.bashrcに記載する
「環境変数もエイリアスも全部~/.bashrcに書け」とか「ターミナルで常にログインシェルを起動しろ」と言っている記事がよくあるが、これはどちらもまずいやり方である。
これをやると、ターミナル以外から起動するプログラム(GUI起動など)に環境変数が渡らなくなってしまうのが最大の問題である。


 - ```~/.profile```
     - 特定のシェルに依存しない環境変数やGUI設定はここに書く
 - ```~/.bash_profile```
     - .profileと.bashrcの存在確認と書き込みだけ(何も足さない)
 - ```~/.bashrc```
     - bashに依存する対話モード向けの設定はここに書く
     - 設定は、.bashrc冒頭の非対話モード脱出コードの後に置く

