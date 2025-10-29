# set $XAUTHORITY on ssh
export XAUTHORITY=$HOME/.Xauthority

# set $DISPLAY on ssh
# https://www.linuxquestions.org/questions/linux-networking-3/ssh-x-cannot-open-display-925852/
if [ ! $DISPLAY ] ; then
    if [ "$SSH_CLIENT" ] ; then
        export DISPLAY=`echo $SSH_CLIENT|cut -f1 -d\ `:0.0
    fi
fi

# fix $DISPLAY on ssh tmux reconnect
#https://www.reddit.com/r/ssh/comments/1aurs0x/ssh_x_forwarding_for_active_tmux_session/
function fix_tmuxenv() {
    eval $(tmux show-environment | sed -e '/^-/d' -e "s/'/'\\\"/g" -e "s/=\(.*\)/='\\1'/" -e "s/^/export /g")
}
#if [ -n "$TMUX" ]; then
#    export DISPLAY="$(tmux show-env | sed -n 's/^DISPLAY=//p')"
#fi

function test_osc52() {
  local msg="OSC52 tmux test"
  local b64
  b64=$(echo -n "$msg" | base64)
  printf "\033Ptmux;\033\033]52;c;%s\007\033\\" "$b64"
}

#{{{ wsl
# https://www.youtube.com/watch?v=mSXOYhfDFYo
# wsl --install Ubuntu
# wsl --unregister Ubuntu
#}}}
#{{{ CentOS
# sudo yum update -y
# sudo yum install libX11
# vim /etc/ssh/sshd_config
# X11Forwarding yes
# X11DisplayOffset 10
# X11UseLocalhost yes
# systemctl restart sshd
#}}}
#{{{ MobaXterm
# terminal color scheme config
# https://sourcegraph.com/github.com/mbadolato/iTerm2-Color-Schemes/-/blob/mobaxterm/catppuccin-mocha.ini
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
#}}}
#{{{ Alacritty
#https://stackoverflow.com/questions/34932495/forward-x11-failed-network-error-connection-refused
#
# $env:DISPLAY="localhost:0"
# ssh.exe -Y jasonli@atcpcw10
#
# C:\Windows\System32\wsl.exe -d Ubuntu
# C:\Windows\System32\wsl.exe -d Debian
#
# config
# $env:APPDATA\alacritty\alacritty.yml
#
# colors:
#     primary:
#         background: "#000000" # base
#         foreground: "#CDD6F4" # text
#         # Bright and dim foreground colors
#         dim_foreground: "#CDD6F4" # text
#         bright_foreground: "#CDD6F4" # text
#
#     # Cursor colors
#     cursor:
#         text: "#1E1E2E" # base
#         cursor: "#F5E0DC" # rosewater
#     vi_mode_cursor:
#         text: "#1E1E2E" # base
#         cursor: "#B4BEFE" # lavender
#
#     # Search colors
#     search:
#         matches:
#             foreground: "#1E1E2E" # base
#             background: "#A6ADC8" # subtext0
#         focused_match:
#             foreground: "#1E1E2E" # base
#             background: "#A6E3A1" # green
#         footer_bar:
#             foreground: "#1E1E2E" # base
#             background: "#A6ADC8" # subtext0
#
#     # Keyboard regex hints
#     hints:
#         start:
#             foreground: "#1E1E2E" # base
#             background: "#F9E2AF" # yellow
#         end:
#             foreground: "#1E1E2E" # base
#             background: "#A6ADC8" # subtext0
#
#     # Selection colors
#     selection:
#         text: "#1E1E2E" # base
#         background: "#F5E0DC" # rosewater
#
#     # Normal colors
#     normal:
#         black: "#45475A" # surface1
#         red: "#F38BA8" # red
#         green: "#A6E3A1" # green
#         yellow: "#F9E2AF" # yellow
#         blue: "#89B4FA" # blue
#         magenta: "#F5C2E7" # pink
#         cyan: "#94E2D5" # teal
#         white: "#BAC2DE" # subtext1
#
#     # Bright colors
#     bright:
#         black: "#585B70" # surface2
#         red: "#F38BA8" # red
#         green: "#A6E3A1" # green
#         yellow: "#F9E2AF" # yellow
#         blue: "#89B4FA" # blue
#         magenta: "#F5C2E7" # pink
#         cyan: "#94E2D5" # teal
#         white: "#A6ADC8" # subtext0
#
#     # Dim colors
#     dim:
#         black: "#45475A" # surface1
#         red: "#F38BA8" # red
#         green: "#A6E3A1" # green
#         yellow: "#F9E2AF" # yellow
#         blue: "#89B4FA" # blue
#         magenta: "#F5C2E7" # pink
#         cyan: "#94E2D5" # teal
#         white: "#BAC2DE" # subtext1
#
#     indexed_colors:
#         - { index: 16, color: "#FAB387" }
#         - { index: 17, color: "#F5E0DC" }
#}}}

# echo "Shell=$SHELL $BASH_VERSION"
# language config
# https://samwhelp.github.io/note-ubuntu-18.04/read/howto/install/locale/
# locale -a
# locale
# if en_US.utf-8 does not exist
#   sudo locale-gen en_US.UTF-8
export LANG="en_US.utf-8"
export LC_ALL=

# set $PATH
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.local/script:${PATH}"

# set $TERM
# https://unix.stackexchange.com/questions/574669/clearing-tmux-terminal-throws-error-tmux-256color-unknown-terminal-type
#infocmp -x xterm-256color > saved
#tic -x saved
# check terminfo
# infocmp tmux-256color
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi

#{{{ alias
alias rebash='source $HOME/.bashrc';
alias vim="nvim -O"
alias tmux="tmux -u"
alias tmuxs="tmux-sessionizer"
alias ls="ls --color=never --classify --group-directories-first"
alias eixt="exit"
alias exti="exit"
#}}}
#{{{ bind
#https://superuser.com/questions/1786563/how-do-i-run-a-bash-script-automatically-everytime-i-hit-ctrl-s
#stty stop ''
#bind '"\C-s":nop'
#bind '"\C-sf":nop'
#bind '"\C-se":nop'
bind '"\C-af":"tmux-sessionizer\n"'
bind '"\C-ae":"tmux-session-selector\n"'
#}}}

##{{{
#function parse_git_dirty {
#  status=$(git status --porcelain -b 2> /dev/null)
#  aheadRegex="ahead ([0-9]+)"
#  behindRegex="behind ([0-9]+)"
#
#  [[ $status =~ $aheadRegex ]] && ahead="${BASH_REMATCH[1]}" || ahead="0"
#  [[ $status =~ $behindRegex ]] && behind="${BASH_REMATCH[1]}" || behind="0"
#
#  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo -n ", dirty"
#  [[ $ahead != "0" ]] && echo -n ", ↑${ahead}"
#  [[ $behind != "0" ]] && echo -n ", ↓${behind}"
#}
#function parse_git_stash {
#  [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo " \/ stash"
#}
#function parse_git_branch {
#  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)$(parse_git_stash)/"
#}
#export PS1='\[\e[0;33m\]${HOSTNAME}\[\e[m\]  |  \W  |  \[\e[0;36m\]$(parse_git_branch)\[\e[m\]\n${USER} $ '
##}}}

# GIT_PS1
#GIT_PS1_SHOWDIRTYSTATE='y'
#GIT_PS1_SHOWSTASHSTATE='y'
#GIT_PS1_SHOWUNTRACKEDFILES='y'
#GIT_PS1_DESCRIBE_STYLE='contains'
#GIT_PS1_SHOWUPSTREAM='auto'
#source /etc/bash_completion.d/git-prompt
#export PS1="\[\033[33m\][\w] \[\e[91m\]\$(__git_ps1) \n\[\033[33m\][\j] > \[\033[0m\]"

#{{{ git .gitconfig
# https://www.youtube.com/watch?v=aolI_Rz0ZqY&t=905s
# git config --global user.name "Wen-Jie Li"
# git config --global user.email "jnjn0022@gmail.com"
git config --global push.default simple
git config --global pull.rebase true
# https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/
git config --global alias.wt "worktree"
git config --global alias.root 'rev-parse --show-toplevel'
# :G ls
# :G ls %
# :G ls --grep=<pattern> --author=<author>
# --name-only
# --stat
git config --global alias.ls "log --decorate --oneline --graph"
git config --global alias.ll "log --decorate --oneline --graph --date=format:%Y-%m-%d\ %H:%M --pretty=format:'%C(auto,yellow)%h %C(auto,blue)%ad %C(auto,green)%<(7,trunc)%aN%C(reset)%C(auto)%d%C(reset)%<(70,trunc) %s'"
git config --global alias.rl "reflog --pretty=format:'%Cred%h%Creset %C(yellow)%gd%C(reset) %C(auto)%gs%C(reset) %C(green)(%cr)%C(reset) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.tree "log --graph --simplify-by-decoration --pretty=format:'%C(auto,blue)%cr%C(auto)%d' --all"
# > git ft --all -p
git config --global alias.ft "fetch"
# > git st -sb
git config --global alias.st "status"
# > git br -avv
# > git br -vv
git config --global alias.br "branch"
# V -> :0Gclog
# :Gedit <commit_id>:%
# :Gedit <commit_id>:<file_name>
# > git sh --name-only --oneline <commit_id> 
# > git sh <commit_id>:<file_name> | vim -
# > git sh <commit_id>:% | vim -
git config --global alias.sh "show"
git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.pk "cherry-pick"
git config --global merge.commit false
git config --global merge.ff false
# do # obtain from the other file
# dp # put to the other file
# ]c # jump to the next diff
# [c # jump to the previous diff
git config --global merge.tool nvimdiff
git config --global merge.conflictstyle diff3  
git config --global mergetool.prompt false
# > git df <commit_id> <filename>
# > git df <commit_id> <commit_id> <filename>
# > git df --stat <commit_id>
# > git df --stat <commit_id> <commit_id>
# :Gvdiffsplit :0
# :Gvdiffsplit HEAD:%
# :Gvdiffsplit <commit_id>:%
git config --global alias.df "difftool"
git config --global diff.tool nvimdiff
git config --global diff.algorithm myers
git config --global difftool.prompt false
git-diff-with-abs-path() {
    local path

    path=$(git rev-parse --show-toplevel) &&
    git diff --name-only "$@" | sed "s,^,$path/,"
}
#}}}
#{{{ git prompt
#https://blog.sasworkshops.com/showing-status-in-the-git-bash-prompt/

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
    GIT_PROMPT_IGNORE_SUBMODULES=1
    GIT_PROMPT_START_ROOT="\[\033[33m\][\w]\[\033[0m\]"
    GIT_PROMPT_START_USER="\[\033[33m\][\w]\[\033[0m\]"
    GIT_PROMPT_END_ROOT=" \n\[\033[33m\][\j] > \[\033[0m\]"
    GIT_PROMPT_END_USER=" \n\[\033[33m\][\j] > \[\033[0m\]"
    source ${file}
    #echo "Prompt ${file}"
#else
    #echo "Prompt [Warning] ${file} not exist"
fi
#}}}



# create function call
function cin () {
    xsel -i -b
}

function cout () {
    xsel -o -b
}

function yy () {
    if [[ $# != 1 ]]; then
        pwd | tr -d '\n' | xsel -i -b
        echo "pp $(pwd)"
    else
        readlink -f $1 | tr -d '\n' | xsel -i -b
        echo "pp $(pwd)/${1}"
    fi
}

function pp () {
    if [[ $# != 1 ]]; then
        target="$(cout)"
    else
        target="${1}"
    fi

    if [[ -d "${target}" ]]; then
        cd "${target}"
        echo "yy ${target}"
    else
        vim "${target}"
        echo "yy ${target}"
    fi
}

# fzf config
#if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
#   export FZF_DEFAULT_OPTS='-m'
#fi

##https://www.youtube.com/watch?v=F8dgIPYjvH8&ab_channel=AndrewCourter
# > fd | fzf
# > cd $(fd | fzf)
function ff () {
    selection="$(fd | fzf | tr -d '\n')"
    selection="$(pwd)/${selection}"
    echo "${selection}" | tr -d '\n' |xsel -i -b
    echo "pp $(cout)"
}

#function cdw () {
#    cd "$(git worktree list | fzf | awk '{print $1}')"
#}

#function fb () {
#    selection="$(git worktree list | fzf | awk '{print $1}')"
#
#    echo "${selection}" | tr -d '\n' |xsel -i -b
#    echo "Copy to clipboard: $(cout)"
#}

##https://www.olafalders.com/2024/06/14/one-line-fuzzy-find-for-git-worktree/
#function cdb () {
#    cd "$(git worktree list | fzf | awk '{print $1}')"
#}

function bb () {
    CUR_TIME=`date +%Y%m%d_%H%M%S`
    if [ $# != 1 ]; then
        selection="$(fd | fzf | tr -d '\n')"
        if [ -z $selection ]; then
            echo "No backup"
        else
            selection="$(echo $selection | sed 's/\/$//g')"
            selection="$(pwd)/${selection}"
            eval `cp -rf $selection $selection.bak.$CUR_TIME`
            echo "Backup: $selection.bak.$CUR_TIME"
        fi
    else
        selection="$(echo $1 | sed 's/\/$//g')"
        eval `cp -rf $selection $selection.bak.$CUR_TIME`
        echo "Backup: $selection.bak.$CUR_TIME"
    fi
}

#function ff () {
#    if [ $# != 1 ]; then
#        if [ -z $1 ]; then
#            clear; echo "[$(pwd)]"; ls -a;
#            selection="$(ls -a | fzf --reverse --height 70%)"
#            if [[ -d "$selection" ]]; then
#                cd "$selection"
#            else
#                vim "$selection"
#            fi
#        fi
#    else
#        cd $1
#    fi
#}

function run_install_tool() {
    # prerequisite
    sudo hwclock --hctosys
    sudo apt-get update
    sudo apt-get install build-essential

    # appimage prerequisite
    # if you can't open tmux and nvim appimage
    #   if you can has the root authoirty
    #       sudo apt-get install libfuse2
    #   if can't
           sudo apt-get install fuse libfuse2
    #       sudo modprobe fuse
    #       sudo groupadd fuse
    #       user="$(whoami)"
    #       sudo usermod -a -G fuse $user
    #   if can't
    #       -appimage-extract and amend the AppRun file

    # treesitter prerequisite
    # https://github.com/sindresorhus/guides/blob/main/npm-global-without-sudo.md
    # https://stackoverflow.com/questions/18088372/how-to-npm-install-global-not-as-root
    sudo apt-get install g++
    sudo apt-get install nodejs
    sudo apt-get install npm
    sudo npm install -g tree-sitter-cli

    # mason prerequisite
    sudo apt-get install ninja-build
    sudo apt-get install gettext
    sudo apt-get install cmake
    sudo apt-get install unzip
    sudo apt-get install gzip
    sudo apt-get install curl
    sudo apt-get install tar
    sudo apt-get install wget
    #sudo apt-get install python3
    #sudo apt-get install python3-venv

    # mason install bash
    sudo apt-get install shellcheck

    # python3 provider
    sudo apt-get install python3-pip
    sudo pip3 install neovim
    # nodejs porvider
    sudo npm install -g neovim

    # install bash-git-promt
    folder="${HOME}/.local/lib/bash-git-prompt"
    url="https://github.com/magicmonty/bash-git-prompt.git"
    if [ ! -d "$folder" ] ; then
        git clone "$url" "$folder" --depth=1
    fi
}

# synopsys tool conifg
file="${HOME}/synopsys/.bashrc.synopsys"
if [ -f "${file}" ]; then
    source "${file}"
    printf "source ${file}\n"
fi
# umvc 2.3.2 config
file="${HOME}/synopsys/.bashrc.uvmc"
if [ -f "${file}" ]; then
    source "${file}"
    printf "source ${file}\n"
fi

printf "VCS_HOME: ${VCS_HOME}\n"
printf "UVM_HOME: ${UVM_HOME}\n"
printf "UVMC_HOME: ${UVMC_HOME}\n"

#sudo apt install -y gcc wget iputils-ping python3-pip git bear tig shellcheck ripgrep
#
## 安装 neovim 的各种依赖 https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites
#sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
#brew install autossh
#curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
#gunzip terminfo.src.gz
#tic terminfo.src

#https://stackoverflow.com/questions/1441010/the-shortest-possible-output-from-git-log-containing-author-and-date


