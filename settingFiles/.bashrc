# ---------------------------------------------------------------
# This setting file is read, when you shart new bash.
# If you don't use bash for login-shell,
# this file read when you start bash on other shell, as interactive mode.
# ---------------------------------------------------------------

# Setting for displaying infomation

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# This "PS1" parameter have difference of settings between each shells.
PS1="\[\033[34m\]\h\[\033[0m\]:\[\033[32m\]\w\[\033[0m\]$ "

# Setting colors
export CLICOLOR=1
# lsの出力を色付き表示
# BSD(macOS) : ls -G
export LSCOLORS=gxfxcxdhbxegehabahhfhg
# GNU(Linux) : ls --color
export LS_COLORS="di=04;36;49:ln=35;49:so=32;49:pi=33;47:ex=31;49:bd=34;46:cd=34;47:su=30;41:sg=30;47:tw=04;37;47:ow=04;37;45:*.py=32;49:*.c=36;49:*.cpp=36;49:*.cc=36;49:*.h=32;49:*.hh=32;49:*.md=31;49"

# mac ls
#alias ls='ls -GF'
# GNU ls
alias ls='gls --color'


# Setting general-purpose alias
alias firefox="open -a /Applications/Firefox.app"
alias mail="open -a /Applications/Thunderbird.app"
alias chrome="open -a /Applications/Google¥ Chrome"
alias line="open -a /Applications/LINE.app"
alias python="python3"
alias pip="pip3"

