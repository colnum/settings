# Setting for VSCode

## 日本語化
アクティビティバーの拡張機能から、「japanese」で検索すると出てくる「Japanese Language Pack for VS Code」をインストールする。
再起動するとvscodeが日本語化されている。

## ワークスペースの設定
1. アクティビティバーのexploreから適当に新しいフォルダを開く。
2. メニューバーのFileからワークスペースとして保存を選択する。
3. macまたはlinuxの場合はホームディレクトリ、Windowsの場合は適切な場所にworkspaceのファイルを保存する。
4. workspaceの中身をMySettingのworkspaceの中身を参考に書き換えるか、コピーアンドペーストする。
5. markdown-pdfに関する設定は以下の項目に記述する。

## Markdownに関する設定
1. アクティビティバーの拡張機能から、「markdown」で検索すると出てくる「Markdown Preview Enhanced」と「Markdown PDF」をインストールする。
2. workspaceの設定ファイルに記述したMyPdfStyle.cssを作成する。設置場所はworkspaceファイルと同様、ホームディレクトリが良い。
3. スタイルシートの記述方法の説明については別紙に譲ることとする。
4. VScodeでmarkdown形式のファイルを開き、コマンドパレットから「markdown pdf」で出てくる「markdown pdf: export (pdf)」を実行する
5. vscodeでpdfを閲覧する場合、アクティビティバーの拡張機能から「pdf」と検索したら出てくる「vscode-pdf」をインストールし、アクティビティバーのexplorから生成したpdfファイルを開くとvscode上でpdfファイルを閲覧できる。
6. markdown pdfに関する設定は以下サイトを参考にした。
https://github.com/yzane/vscode-markdown-pdf/blob/master/README.ja.md#markdown-pdfheadertemplate
https://qiita.com/kerobot/items/0227c0ee726e9ceca7db
https://h-s-hige.hateblo.jp/entry/20190405/1554467885


## csvに関する設定
アクティビティバーの拡張機能から、「csv」で検索すると出てくる「Edit csv」「Rainbow CSV」をインストールする

## Draw.ioに関する設定
アクティビティバーの拡張機能から、「draw」で検索すると出てくる「Draw.io Integration」をインストールする

## icon
アクティビティバーの拡張機能から、「vscode-icons」で検索すると出てくる「vscode-icons」をインストールする

## ファイル操作
アクティビティバーの拡張機能から、「duplicate」で検索すると出てくる「Duplicate action」をインストールする
アクティビティバーのexploreから右クリックでファイルやディレクトリを複製できるようになる

## TODO
その他、vscode自体の設定、setting.jsonなどを記載する
