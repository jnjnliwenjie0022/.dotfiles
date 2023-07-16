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

# workspace config
alias rebash='source ~/.bashrc'; echo "source ~/.bashrc"; echo "source ~/.bashrc.workflow"
alias vim="nvim -O"
alias tmux="tmux -u"
export PATH="~/.local/bin:${PATH}"
export PATH="~/.local/script:${PATH}"

# enable zoxide
eval "$(zoxide init bash)"

# bind key
bind '"\C-af":"tmux-sessionizer\n"'

cin () {
    xclip -selection c
}

cout () {
    xclip -selection clipboard -o
}

fcd () {
    # As others have explained, the directory is changed in the child process of your script,
    # not in the terminal process from which the script is called. After the child process dies,
    # you are back in the terminal which is left where it was.
    cd "$(find -type d | fzf)"
}

fvim () {
    vim "$(find -type f | fzf)" 
}

pwdy () {
    # clipboard has same problem from time to time
    # reset the terminal can fix
    echo "Copy to clipboard: $(pwd)"
    pwd | tr -d '\n' | xclip -selection c
}

# tmux config
if [ "$TERM" != "xterm-256color" ]; then
    # in root: need terminfo/
    # or
    # in user: need .terminfo/
    export TERM=xterm-256color; echo "${TERM}"
fi

# prompt conifg
function parse_git_branch() {
     git branch  2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)/"
}
export PS1="\[\033[35m\][\t] \[\033[32m\][\w] \[\e[91m\]\$(parse_git_branch) \n\[\033[1;33m\][\j] > \[\033[0m\]"

#if [ -f "$HOME/.local/share/bash-git-prompt/gitprompt.sh" ]; then
##    https://github.com/magicmonty/bash-git-prompt
#     GIT_PROMPT_ONLY_IN_REPO=1
#     GIT_PROMPT_THEME=Solarized
#     source $HOME/.local/share/bash-git-prompt/gitprompt.sh
#fi

# fzf config
#if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
#  	export FZF_DEFAULT_OPTS='-m'
#fi

if [ -f ~/synopsys/.bashrc.synopsys ]; then
    . ~/synopsys/.bashrc.synopsys
fi
