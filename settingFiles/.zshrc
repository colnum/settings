# ------------------------------------------------------------
# Import {{{
#source ~/.zplug/init.zsh
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# Plugins {{{
### Added by Zplugin's installer
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
#zinit load momo-lab/zsh-abbrev-alias # 略語を展開する
zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
#zinit load zsh-users/zsh-completions # 補完
# プラグインの遅延読み込み
#zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting # 実行可能なコマンドに色付け
#zinit ice wait'!0'; zinit load zsh-users/zsh-completions # 補完
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue, underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# History {{{
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000000
bindkey '^P' history-beginning-search-backward # 先頭マッチのヒストリサーチ
bindkey '^N' history-beginning-search-forward # 先頭マッチのヒストリサーチ
# ログアウトする前にヒストリを履歴に残す
setopt inc_append_history
# 同時に起動したzsh間でヒストリを共有する
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 高機能なワイルドカード展開を使用する
setopt extended_glob
#ヒストリに時刻情報もつける
setopt EXTENDED_HISTORY
#ヒストリの一覧を読みやすい形に変更
HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "
#重複するヒストリを持たない
setopt HIST_IGNORE_ALL_DUPS
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# Color {{{
autoload -Uz colors
colors

# Setting colors
export CLICOLOR=1
# lsの出力を色付き表示
# BSD(macOS) : ls -G
export LSCOLORS=gxfxcxdhbxegehabahhfhg
# GNU(Linux) : ls --color
export LS_COLORS="di=04;36;49:ln=35;49:so=32;49:pi=33;47:ex=31;49:bd=34;46:cd=34;47:su=30;41:sg=30;47:tw=04;37;47:ow=04;37;45:*.py=32;49:*.c=36;49:*.cpp=36;49:*.cc=36;49:*.h=32;49:*.hh=32;49:*.md=31;49"

# dircolorsファイルの内容をLS_COLORSに設定し、glsコマンドに反映させる
# mac ls
#alias ls='ls -GF'
eval $(gdircolors ~/.dir_colors)
# GNU ls
alias ls='gls --color'
#eval $(dircolors ~/.dir_colors)

# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# Prompt {{{
# %M    ホスト名
# %m    ホスト名
# %d    カレントディレクトリ(フルパス)
# %~    カレントディレクトリ(フルパス2)
# %C    カレントディレクトリ(相対パス)
# %c    カレントディレクトリ(相対パス)
# %n    ユーザ名
# %#    ユーザ種別
# %?    直前のコマンドの戻り値
# %D    日付(yy-mm-dd)
# %W    日付(yy/mm/dd)
# %w    日付(day dd)
# %*    時間(hh:flag_mm:ss)
# %T    時間(hh:mm)
# %t    時間(hh:mm(am/pm))
# %n:username %m:hostname %T:time(HH:MM)
# %*:time(HH:MM:SS) %D:date(YY-MM-DD)
# %~:current directly
# %F{指定色}色をつけたい文字%f
# ${VIMODE} show vim mode, insert or normal

# PROMPTは画面左側の表示
# PROMPT='[%B%F{cyan}%*%f%b:%B%F{green}%n%f%b]$ '
# PROMPT='[%B%F{cyan}%*%f%b:%B%F{green}%~%f%b]$ '
# PROMPT='[%B%F{blue}%m%f%b:%B%F{green}%~%f%b]$ '
PROMPT='%B%F{blue}%m%f%b:%B%F{green}%~%f%b$ '

# RPROMPTは画面右側の表示
#RPROMPT='%B%F{blue}[%d]%f%b'
#RPROMPT='${VIMODE}[%B%F{cyan}%*%f%b]'
# }}} Prompt
# ------------------------------------------------------------

# ------------------------------------------------------------
# 補完機能 {{{
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# lsの出力を色付き表示
zstyle ':completion:*' list-colors 'di=36;49' 'ln=35;49' 'so=32;49' 'pi=33;47' 'ex=31;49' 'bd=34;46' 'cd=34;47' 'su=30;41' 'sg=30;47'  'tw=37;45' 'ow=37;46'

# tabの補完候補にもシンタックスハイライト
zstyle ':completion:*' verbose yes
# !COUTION! macとLinuxで場合わけの必要がアリそう
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# =の後ろでも補完
setopt magic_equal_subst
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# Git の情報を取得{{{
# vcs_info
#autoload -Uz vcs_info
#setopt prompt_subst
#zstyle ':vcs_info:git:*' check-for-changes true
#zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
#zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
#zstyle ':vcs_info:*' formats "%F{green}%c%u[git: %b]%f"
#zstyle ':vcs_info:*' actionformats '[%b|%a]'
#precmd () { vcs_info }
#RPROMPT='${vcs_info_msg_0_} '$RPROMPT
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# キーバインドをvim化 {{{
bindkey -v
# vim キーバインドでもctrl+N ctrl+Pは検索に使える
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# vim モード表示
function zle-line-init zle-keymap-select {
    VIM_NORMAL="[%B%F{red}NORMAL%f%b]"
    VIM_INSERT="[%B%F{green}INSERT%f%b]"
    #RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}[%B%F{cyan}%*%f%b]"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# terminal title {{{
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac
# }}}
# ------------------------------------------------------------

# ------------------------------------------------------------
# オプション {{{
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# フローコントロールを無効にする
setopt no_flow_control
# Ctrl+Dでzshを終了しない
setopt ignore_eof
# '#' 以降をコメントとして扱う
setopt interactive_comments
# no match 回避
setopt nonomatch
# バックグラウンドプロセスの状態変化を即時に知らせる
setopt notify
# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value
# ディレクトリ名だけでcdする
#setopt auto_cd
# cd したら自動的にpushdする
#setopt auto_pushd
# 重複したディレクトリを追加しない
#setopt pushd_ignore_dups
# cdした後、自動的にls する
#function chpwd() { ls }
# remove file mark
#unsetopt list_types
# set file mark
#setopt list_types

# }}}
# ------------------------------------------------------------
