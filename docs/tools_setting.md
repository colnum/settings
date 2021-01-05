# Setting for CLI tools
.profileはもう少しジェネリックな表記をしなければならない
これらのインストールはある程度スクリプト化しておくのが良いかもしれない

 - tmux
 - cmake
 - rust
 - rust tools
 - Hyper
 - Draw.io

## nvidia drivers
https://qiita.com/yto1292/items/463e054943f3076f36cc

## tmux
今回はversion3.1bのtmuxを使用することとする。

公式サイトはここ
 - https://github.com/tmux/tmux/wiki

依存ライブラリもローカルビルドする場合、以下を事前に行う。

 - libevent最新版は: http://libevent.org/
 - ncurses最新版は: ftp://ftp.gnu.org/gnu/ncurses/

pkg-configのローカルビルドに関しては
```
# wget https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
# tar xvfz pkg-config-0.29.2.tar.gz
# cd pkg-config-0.29.2
# ./configure --prefix=/usr/local/pkg_config/0_29_2 --with-internal-glib
# make
# make install
```


```
sudo apt install pkg-config
cd
mkdir local
cd local
mkdir source
cd source

# Get&build libevent
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar zxf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure --prefix=${HOME}/local
make
make install

# Get & build ncurses
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
tar zxf ncurses-6.0.tar.gz
cd ncurses-6.0
./configure --enable-pc-files --prefix=${HOME}/local --with-pkg-config-libdir=${HOME}/local/lib/pkgconfig --with-termlib
make
make install

# Get & build tmux
sudo apt remove tmux
sudo apt install make automake autogen libevent-dev libncurses5-dev bison gcc autoconf pkg-config zlib1g-dev curl libbison-dev
wget https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b.tar.gz
tar zxf tmux-3.1b.tar.gz
cd tmux-3.1b
sh autogen.sh
PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig ./configure --prefix=${HOME}/local --enable-static LDFLAGS="-L${HOME}/local/lib" CFLAGS="-I${HOME}/local/include"
make
sudo make install
tmux -V
# tmux 3.1b
```

リンカ関係でうまく動作しない時は以下のようにLD_LIBRARYを設定する。
```
#echo 'alias tmux="LD_LIBRARY_PATH=$HOME/local/lib $HOME/local/bin/tmux"' >> .bashrc
```

.tmux.confに関しては今後検討する

特にsshでログインした際にホストのキーバインドとゲストのキーバインドがかぶってしまい、思ったように操作できない問題を解決したい。



## cmake
cmakeの公式サイトはここ
 - https://cmake.org/download/
 - https://cmake.org/files/
 - https://cmake.org/files/v3.15/

今回はバージョン3.15.7を用いることする

```
cd
cd local
cd source
wget https://cmake.org/files/v3.15/cmake-3.15.7.tar.gz
tar xvf cmake-3.15.7.tar.gz
cd cmake-3.15.7
./configure --prefix=${HOME}/local
make
make install
```

cmakeの使い方に関しては以下を参考にする
 - https://qiita.com/shohirose/items/45fb49c6b429e8b204ac
 - https://qiita.com/termoshtt/items/539541c180dfc40a1189


## Rust

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

~$ cargo --version
cargo 1.34.0 (6789d8a0a 2019-04-01)
~$ rustc --version
rustc 1.34.0 (91856ed52 2019-04-10)
~$ rustdoc --version
rustdoc 1.34.0 (91856ed52 2019-04-10)
~$ rustup --version
rustup 1.17.0 (069c88ed6 2019-03-05)
```

PATHの設定は.profilenに記述した。

## Rust tools

vscodeにrust拡張のLLDB入れてデバッグするの楽しそう

依存ライブラリ
```
sudo apt install libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev
sudo apt install automake autogen libevent-dev libncurses5-dev bison autoconf zlib1g-dev libbison-dev
```


### exa
 - https://github.com/ogham/exa

```
cargo install exa
```

### lsd
 - https://github.com/Peltoche/lsd

```
cargo install lsd
```

### bat
 - https://github.com/sharkdp/bat

```
cargo install --locked bat
```

### tokei
 - https://github.com/XAMPPRocky/tokei

```
cargo install --git https://github.com/XAMPPRocky/tokei.git
```

### fd
 - https://github.com/sharkdp/fd

```
cargo install fd-find
```

### ripgrep
 - https://github.com/BurntSushi/ripgrep

```
cargo install ripgrep
```

### hexyl
 - https://github.com/sharkdp/hexyl

```
cargo install hexyl
```

### procs
 - https://github.com/dalance/procs

```
cargo install procs
```

### delta
 - https://github.com/dandavison/delta

```
cargo install git-delta
```

### Silicon
 - https://github.com/Aloxaf/silicon

```
cargo install silicon
```

### ripgrep-all
 - https://github.com/phiresky/ripgrep-all

no cargo support

### Dust
 - https://github.com/bootandy/dust

```
cargo install du-dust
```

### dutree
 - https://github.com/nachoparker/dutree

```
cargo install dutree
```

### alacritty
 - https://github.com/alacritty/alacritty/blob/master/INSTALL.md

```
git clone https://github.com/alacritty/alacritty.git
cd alacritty
# dependancy linux
# apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
# Linux/windows
cargo build --release
# mac
make app
cp -r target/release/osx/Alacritty.app /Applications/
```

### Wez's Terminal Emulator
 - https://wezfurlong.org/wezterm/install/source.html

```
git clone --depth=1 --branch=master --recursive https://github.com/wez/wezterm.git
cd wezterm
git submodule update --init --recursive
sudo ./get-deps
cargo build --release
cargo run --release -- start
```

## Hyper
以下よりインストーラをダウンロードし、インストールする
https://hyper.is/

カスタムなどは以下などを参考にする
https://qiita.com/vimyum/items/44478a51ef3a6f49804f

## Draw.io
以下よりインストーラをダウンロードし、インストールする
https://github.com/jgraph/drawio-desktop/releases