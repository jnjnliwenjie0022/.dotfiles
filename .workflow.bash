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

# https://samwhelp.github.io/note-ubuntu-18.04/read/howto/install/locale/
# language config
# local -a
# local
# if en_US.utf-8 does not exist
#   sudo locale-gen en_US.UTF-8
export LANG="en_US.utf-8"
export LC_ALL=

# create command
echo "Shell=$SHELL $BASH_VERSION"
alias rebash='source $HOME/.bashrc'; echo "source $HOME/.bashrc"; echo "source $HOME/.workflow.bash"
alias vim="nvim -O"
alias tmux="tmux -u"
alias ls="exa"
alias eixt="exit"

# workspace config
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.local/script:${PATH}"

# enable zoxide
eval "$(zoxide init bash)"

# bind key
bind '"\C-af":"tmux-sessionizer\n"'

# create function call
function cin () {
    xsel -i -b
}

function cout () {
    xsel -o -b
}

function pwdx () {
    # clipboard has same problem from time to time
    # reset the terminal can fix
    pwd | tr -d '\n' | xsel -i -b
    echo "Copy to clipboard: $(pwd)"
}

function cdx () {
    cd "$(cout)"
    echo "Paste from clipboard: $(cout)"
}

function fzfx () {
    target="$(fzf | tr -d '\n')"
    target=""$(pwd)"/${target}"

    echo "${target}" | xsel -i -b
    echo "Copy to clipboard: $(cout)"
}

function bak () {
    CUR_TIME=`date +%Y%m%d_%H%M%S`
    if [ $# != 1 ]; then
        echo "usage: backup dir/file"
    else
        eval `cp -r $1 $1.bak.$CUR_TIME`
    fi
}

function ff () {
    if [ $# != 1 ]; then
        if [ -z $1 ]; then
            clear; echo "[$(pwd)]"; ls -a;
            selection="$(ls -a | fzf --reverse --height 70%)"
            if [[ -d "$selection" ]]; then
                cd "$selection"
            else
                vim "$selection"
            fi
        fi
    else
        cd $1
    fi
}

# tmux config
export TERM=tmux-256color; echo "TERM=${TERM}" # in root: need terminfo/
# check terminfo
# infocmp tmux-256color

function run_install_workflow_widget() {
    # https://github.com/magicmonty/bash-git-prompt
    folder="${HOME}/.local/lib/bash-git-prompt"
    url="https://github.com/magicmonty/bash-git-prompt.git"
    if [ ! -d "$folder" ] ; then
        git clone "$url" "$folder" --depth=1
    fi
}

# prompt conifg
function parse_git_branch() {
     git branch  2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}
export PS1="\[\033[33m\][\w] \[\e[91m\]\$(parse_git_branch) \n\[\033[33m\][\j] > \[\033[0m\]"

# bash-git-promt config
file="${HOME}/.local/lib/bash-git-prompt/gitprompt.sh"
if [ -f ${file} ]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_SHOW_UPSTREAM=1
    GIT_PROMPT_FETCH_REMOTE_STATUS=1
    GIT_PROMPT_START_ROOT="\[\033[33m\][\w]\[\033[0m\]"
    GIT_PROMPT_START_USER="\[\033[33m\][\w]\[\033[0m\]"
    GIT_PROMPT_END_ROOT=" \n\[\033[33m\][\j] > \[\033[0m\]"
    GIT_PROMPT_END_USER=" \n\[\033[33m\][\j] > \[\033[0m\]"
    source ${file}
fi

# fzf config
#if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
#   export FZF_DEFAULT_OPTS='-m'
#fi

if [ -f $HOME/synopsys/.bashrc.synopsys ]; then
    . $HOME/synopsys/.bashrc.synopsys
fi
