# terminal color scheme config 
# https://sourcegraph.com/github.com/mbadolato/iTerm2-Color-Schemes/-/blob/mobaxterm/catppuccin-mocha.ini
#
# Paste the following configurations in the corresponding place in MobaXterm.ini.
# Setting->Configuration->Terminal->Default terminal color setting->import catppuccin-mocha.ini
#
# Theme: catppuccin-mocha
# [Colors]
# DefaultColorScheme=0
# BackgroundColour=0,0,0
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

# if you can't open tmux and nvim appimage
#   if you can has the root authoirty
#       sudo apt update
#       sudo apt-get install libfuse2
#   if can't
#       -appimage-extract and amend the AppRun file

# fundimantal config
set -o vi
# https://samwhelp.github.io/note-ubuntu-18.04/read/howto/install/locale/
# language config
# local -a
# local
# if en_US.utf-8 does not exist
#   sudo locale-gen en_US.UTF-8
export LANG="en_US.utf-8"
export LC_ALL=

# create command
alias rebash='source $HOME/.bashrc'; echo "source $HOME/.bashrc"; echo "source $HOME/.bashrc.workflow"
alias vim="nvim -O"
alias tmux="tmux -u"
alias ls="lsd --icon never"

# workspace config
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.local/script:${PATH}"

# enable zoxide 
eval "$(zoxide init bash)"

# enable starship
eval "$(starship init bash)"

# bind key
bind '"\C-af":"tmux-sessionizer\n"'

# create function call
function cin () {
    xsel -i -b
}

function cout () {
    xsel -o -b
}

function pwdy () {
    # clipboard has same problem from time to time
    # reset the terminal can fix
    echo "Copy to clipboard: $(pwd)"
    pwd | tr -d '\n' | xsel -i -b
}

#function fcd () {
#    # As others have explained, the directory is changed in the child process of your script,
#    # not in the terminal process from which the script is called. After the child process dies,
#    # you are back in the terminal which is left where it was.
#    cd "$(find -type d | fzf)"
#}
#
#function fvim () {
#    vim "$(find -type f | fzf)" 
#    vim "$(fd | fzf)"
#}

# tmux config
export TERM=tmux-256color; echo "TERM=${TERM}" # in root: need terminfo/
# check terminfo
# infocmp tmux-256color

# prompt conifg
#function parse_git_branch() {
#     git branch  2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
#}
#export PS1="\[\033[32m\]✔ \[\033[33m\][\w] \[\e[91m\]\$(parse_git_branch) \n\[\033[33m\][\j] > \[\033[0m\]"
#
## bash-git-promt config
## https://github.com/magicmonty/bash-git-prompt
## git clone https://github.com/magicmonty/bash-git-prompt.git ~/.local/script/.bash-git-prompt --depth=1
#if [ -f "$HOME/.local/script/.bash-git-prompt/gitprompt.sh" ]; then
#    GIT_PROMPT_ONLY_IN_REPO=1
#    GIT_PROMPT_START_ROOT="\[\033[32m\]✔ \[\033[33m\][\w]\[\033[0m\]"
#    GIT_PROMPT_START_USER="\[\033[32m\]✔ \[\033[33m\][\w]\[\033[0m\]"
#    GIT_PROMPT_END_ROOT=" \n\[\033[33m\][\j] > \[\033[0m\]"
#    GIT_PROMPT_END_USER=" \n\[\033[33m\][\j] > \[\033[0m\]"
#    source $HOME/.local/script/.bash-git-prompt/gitprompt.sh
#fi

# fzf config
#if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
#  	export FZF_DEFAULT_OPTS='-m'
#fi

if [ -f $HOME/synopsys/.bashrc.synopsys ]; then
    . $HOME/synopsys/.bashrc.synopsys
fi
