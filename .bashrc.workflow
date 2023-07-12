# workspace config
alias vim="nvim -O"
alias tmux="tmux -u"
alias rebash='source ~/.bashrc'; echo "source ~/.bashrc"
export PATH="~/.local/bin:${PATH}"
export PS1="\[\033[35m\][\t] \[\033[32m\][\w] \[\e[91m\]\$(parse_git_branch) \n\[\033[1;33m\][\j] > \[\033[0m\]"

if [ "$TERM" != "xterm-256color" ]; then
    # in root: need terminfo/
    # or
    # in user: need .terminfo/
    export TERM=xterm-256color 
fi

if type rg &> /dev/null; then
   	export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
  	export FZF_DEFAULT_OPTS='-m'
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# terminal color scheme setting
# https://sourcegraph.com/github.com/mbadolato/iTerm2-Color-Schemes/-/blob/mobaxterm/catppuccin-mocha.ini
#
# Paste the following configurations in the corresponding place in MobaXterm.ini.
# Setting->Configuration->Terminal->Default terminal color setting->import catppuccin-mocha.ini
#
#
# Theme: catppuccin-mocha
# [Colors]
# DefaultColorScheme=0
# BackgroundColour=28,28,28
# ForegroundColour=205,214,244
# CursorColour=245,224,220
# Black=69,71,90
# Red=243,139,168
# BoldGreen=166,227,161
# BoldYellow=249,226,175
# BoldBlue=137,180,250
# BoldMagenta=245,194,231
# BoldCyan=148,226,213
# BoldWhite=166,173,200
# Green=166,227,161
# Yellow=249,226,175
# Blue=137,180,250
# Magenta=245,194,231
# Cyan=148,226,213
# White=186,194,222
# BoldBlack=88,91,112
# BoldRed=243,139,168
