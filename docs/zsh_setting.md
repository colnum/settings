# Setting for zsh

ホームディレクトリ直下にこのリポジトリの.zshrcと.zprofileと.zshenvと.profileをコピーし、ログインし直すだけで良い

## .zshenvと.zprofileと.zshrcの使い分け
ログインシェルの場合の読み込み順序

zshenv > zprofile > zshrc > zlogin

インタラクティブシェルの場合の読み込み順序

zshenv > zshrc

$ZDOTDIRはデフォルトでは$HOMEとなっている
### .zshenv
zsh起動時に毎回読まれる。絶対走るマン。

zshの起動形態に依らず、必ず読まれるので、確実に定義される。
開発ツールの場所を示す環境変数PATHなどを書くのが良さそう。
### .zprofile
ログインシェルの起動時に一度だけ読まれる。
### .zshrc
対話的シェルのはじめに読まれる。

補完機能、プロンプトの改造などはインタラクティブシェルに関わるものなので、~/.zshrcに書くのが良さそう。

コマンド履歴の設定もインタラクティブシェルにしか関係がない設定であるため、これも~/.zshrcに記述する。

## 環境に合わせて設定ファイルを分割し、読み込む量を最小限にする
開発で様々なOSを使い分けることはよくある。

完全に別の設定ファイルを準備していたら管理が手間なので、できるかぎり統一したファイルを作成したい。

しかし、環境依存の設定なども存在するため、完全に統一することは困難である。

こうした場合は共通ファイルと個別ファイルという形でファイル分割をしておき、環境に応じて共通ファイルから個別ファイルを読み込むということを実施すれば、ファイル管理や読み込み時間も最小限で済む。

以下のように${OSTYPE}を利用し、個別ファイルを読み分けることが可能である。

```
# .zshrc
case ${OSTYPE} in
    darwin*)
        source ~/.zshrc.darwin
        ;;
    linux*)
        source ~/.zshrc.linux
        ;;
esac
```

## 接尾辞(suffix)エイリアス
ファイルの拡張子とそれを開くアプリケーションプログラムの関連付けとも言える機能。

特定の拡張子を特定のプログラム起動に結びつける。

接尾辞エイリアスは
```
alias -s pdf=xpdf
```

とすると、拡張子が'.pdf'のファイルをコマンドラインのコマンド位置で起動して開くことができる
```
alias -s pdf=xpdf
foo.pdf
```

## zshプラグインマネージャzinit
インストールは以下
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
zinit self-update
```

プラグインのインストール及び起動に関してはzshrcに記述した

## vim操作Zsh Line Editorに関しては以下を参考にする
https://qiita.com/b4b4r07/items/8db0257d2e6f6b19ecb9

## zshの高速化に関しては以下を参考にする
http://blog.aqutras.com/entry/2016/05/12/210000

## lsの色に関して
macではBSD版のlsコマンドがインストールされているため、gdircolorsコマンドが使えない。
そのため以下コマンドによりGNU版lsなどのツールが入ったパッケージをインストールする
```
brew install coreutils
```
そしてエイリアスの設定で
```
alias ls='gls --color=auto'
```
としておく。


カラー設定については以下を参照
https://qiita.com/yuyuchu3333/items/84fa4e051c3325098be3
