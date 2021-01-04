# Vimの設定
.vimrcと.vimフォルダだけをホームディレクトリにコピーし、vimを起動するだけで良い

## color
https://qiita.com/sff1019/items/3f73856b78d7fa2731c7

```
cd ~
cd .vim
mkdir colors
cd ~/Git
git clone https://github.com/tomasr/molokai
mv molokai/colors/molokai.vim ~/.vim/colors/
```

その他、カラーテーマを持ってきて.vim/colorsの中にhoge.vimを設置し、
```
:set colorscheme [tab]
```
で任意のカラーテーマを設定する


## plugin
deinを用いる

.vimrcにdeinのインストールの設定まで記述しているので特に何もしなくて良い

## base
https://qiita.com/ahiruman5/items/4f3c845500c172a02935

