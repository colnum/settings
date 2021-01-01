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

# Setting general-purpose alias
alias firefox="open -a /Applications/Firefox.app"
alias mail="open -a /Applications/Thunderbird.app"
alias chrome="open -a /Applications/Google¥ Chrome"
alias line="open -a /Applications/LINE.app"
alias python="python3"
alias pip="pip3"

