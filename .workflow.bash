#{{{ wsl
# In powershell (local-window)
# https://www.youtube.com/watch?v=mSXOYhfDFYo
# wsl --install Ubuntu
# wsl --unregister Ubuntu
# wsl --list
# wsl -d
#}}}
#{{{ terminal emulator
# # In mobaXterm
# ## terminal color scheme config
# - ref: https://sourcegraph.com/github.com/mbadolato/iTerm2-Color-Schemes/-/blob/mobaxterm/catppuccin-mocha.ini
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

# # In powershell or command prompt
# ## Startup
# > Defualt profile: powershell

# ## Interaction
# Automatically copy selection to clipboard: On

# ## Setting > Appearance
# Hide the tile bar: On

# ## Setting > Color schemes
# - ref: https://github.com/catppuccin/windows-terminal/blob/main/mocha.json
# cursorColor: #F5E0DC
# selectionBackground: #585B70
# background: #27293C -> #000000
# foreground: #CDD6F4
# black: #45475A -> #27293C
# red: #F38BA8
# green: #A6E3A1
# yellow: #F9E2AF
# blue: #89B4FA
# purple: #F5C2E7
# cyan: #94E2D5
# white: #BAC2DE
# brightBlack: #585B70
# brightRed: #F38BA8
# brightGreen: #A6E3A1
# brightYellow: #F9E2AF
# brightBlue: #89B4FA
# brightPurple: #F5C2E7
# brightCyan: #94E2D5 -> #87FFFF
# brightWhite: #A6ADC8

# ## Setting > Defaults > Appearance
# Font size: 20
# Line height: 1
# Cursor Shape: Filled box
# Padding: 0

# ## Setting > Control Panel > Keyboard
# Cursor blink rate: None

# ## Setting > Defaults > Advanced
# Bell notification style: None

# Only in powershell
# $ if (!(Test-Path -Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force }
# $ nvim $PROFILE
#   Set-PSReadLineOption -EditMode Emacs
#   Set-PSReadlineOption -BellStyle None

# # In xterm (local-linux or remote-linux)
# $ vi .Xresources
#   XTerm*background: #1E1E2E
#   XTerm*foreground: #CDD6F4
#   XTerm*color0: #45475A
#   XTerm*color8: #585B70
#   XTerm*color1: #F38BA8
#   XTerm*color9: #F38BA8
#   XTerm*color2: #A6E3AD
#   XTerm*color10: #A6E3AD
#   XTerm*color3: #F9E2AF
#   XTerm*color11: #F9E2AF
#   XTerm*color4: #89B4FA
#   XTerm*color12: #89B4FA
#   XTerm*color5: #F5C2E7
#   XTerm*color13: #F5C2E7
#   XTerm*color6: #94E2D5
#   XTerm*color14: #94E2D5
#   XTerm*color7: #BAC2DE
#   XTerm*color15: #A6ADC8
#   XTerm*faceName: Fira Code:size=12
#   XTerm*faceSize: 12
#   XTerm*selectToClipboard: true
#   XTerm*allowWindowOps: true
# > xrdb -merge .Xresources
#}}}
#{{{ X11 and ssH
# # Concept
# - notice
#   - X11 clipboard can interact with X11 clipboard by X11 (X11 clipboard <-> X11 <-> X11 system clipboard)
#   - tty can interact with X11 system clipboard by OSC52, which is one direction and size limitation (tty -> X11 system clipboard by OSC52)
#   - tmux can interact with X11 clipboard
#   - tmux can interact with tty
#   - nvim can interact with tmux
#   - vim can't interact with anyone
# - combination
#   - local-window X11 enable + X11 system clipboard + tmux
#   - local-window X11 enable + X11 system clipboard + tmux + nvim (nvim interacts with tmux)
#   - local-window terminal support OSC52 + tmux
#   - local-window terminal support OSC52 + tmux + nvim

# # Enable X11
# - In CentOS (remote-linux)
#    > sudo yum update -y
#    > sudo yum install libX11
#    type the following ong the sshd_config file which need root authority
# > vim /etc/ssh/sshd_config
#   X11Forwarding yes
#   X11DisplayOffset 10
#   X11UseLocalhost yes
#   systemctl restart sshd

# # Create ~/.Xauthority
# In remote-linux
#   > xauth list
#       - P.S: create .Xauthority at ~
export XAUTHORITY=$HOME/.Xauthority

# # Easy Way to Access ssh from ssh -Y jasonli@atcpcw10: 22 to ssh r10
# - In local window
#   - In powershell or command prompt
#       > cd ~/.ssh
#       > nvim config
#           Host r10
#               HostName atcpcw10
#               User jasonli
#               Port 22
#               ForwardX11 yes
#               ForwardX11Trusted yes
#               IdentitiesOnly yes
#       > ssh r10

# # Auto Login without Password
# - In local window
#   - In powershell or command prompt
#       > cd ~/.ssh
#       > ssh-keygen
#       > type id_ed25519.pub | ssh jasonli@atcpcw10 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
#           - P.S: copy public key to .ssh/authorized_keys

# # ssh remote-linux
# ## Method1: mobaxterm + wezterm
# - In local window
#   - In mobaxterm
#       P.S: using mobaxterm build-in X11
#       > wezterm
#   - In wezterm
#       > ssh r10

# ## Method2: only wezterm or powershell or command prompt
# - ref: https://stackoverflow.com/questions/65468655/vs-code-remote-x11-cant-get-display-while-connecting-to-remote-server
# - ref: https://wiki.iihe.ac.be/Use_SSH_%26_X11_forwarding_on_Windows
# - In remote-linux
#   > xauth list
#   - check ~/.Xauthority
# - In local window
#   > XLaunch
#       - P.S: App is VcXsrv
#       - tick Multiple windows
#       - type Display number: ${number}
#         - ${number} need to be the same at following setting variable
#       - tick Start no Client
#       - tick Disable access control
#   - In command prompt (create .bat)
#       > set DISPLAY=localhost:${number}.0
#       > echo %DISPLAY%
#       > ssh r10
#   - In powershell (create .ps1)
#       > $env:DISPLAY="localhost:${number}.0"
#       > echo $env:DISPLAY
#       > ssh r10

# # set DISPLAY with .bat
# In local window
#   - In command prompt
#   > nvim display.bat
#     @echo off
#     set DISPLAY=localhost:${number}.0
#     echo DISPLAY is set to %DISPLAY%
#   > dispaly.bat

# # fix $DISPLAY when ssh reconnect with tmux
# - ref: https://www.reddit.com/r/ssh/comments/1aurs0x/ssh_x_forwarding_for_active_tmux_session/
#function fix_tmuxenv() {
#    eval $(tmux show-environment | sed -e '/^-/d' -e "s/'/'\\\"/g" -e "s/=\(.*\)/='\\1'/" -e "s/^/export /g")
#}
# # test osc52
function test_osc52() {
    local msg="OSC52 SUCCESS!!"
    local b64
    b64=$(echo -n "$msg" | base64)
    # - if tmux > 3.2a then must waive it
    #printf "\033Ptmux;\033\033]52;c;%s\007\033\\" "$b64"
    printf "\033]52;c;%s\007" "$b64"
}

# # .wezterm.lua
# - ref: https://www.youtube.com/watch?v=G0_wVLhI-Ds
#}}}
#{{{ export
# # language config
# - ref: https://samwhelp.github.io/note-ubuntu-18.04/read/howto/install/locale/
# > locale -a
# > locale
# if en_US.utf-8 does not exist
# > sudo locale-gen en_US.UTF-8
# > locale -a
#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"
export LC_ALL="C.UTF-8"
export LANG="C.UTF-8"

# # color config
# - disable all the color setting
export LS_COLORS=none

# # set $TERM
# ref: https://unix.stackexchange.com/questions/574669/clearing-tmux-terminal-throws-error-tmux-256color-unknown-terminal-type
# > infocmp -x xterm-256color > saved
# > tic -x saved
# check terminfo
# > infocmp tmux-256color
#if [ -n "$TMUX" ]; then
#    export TERM=tmux-256color
#else
#    export TERM=xterm-256color
#fi
#export TERM=xterm-256color
export TERM=xterm

# set $PATH
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.local/script:${PATH}"
#}}}
#{{{ alias and bind
alias rebash="source $HOME/.bashrc"
alias vim="vi -O"
# - download no dynamic executable
# - ref: https://github.com/tmux/tmux-builds
alias tmux="tmux -u"
alias tmuxs="tmux-sessionizer"
alias ls="ls --color=never --classify --group-directories-first"
alias ll='ls -alF -rvt'
alias eixt="exit"
alias exti="exit"
# - ref: https://superuser.com/questions/1786563/how-do-i-run-a-bash-script-automatically-everytime-i-hit-ctrl-s
# - disalbe Ctrl-s
stty -ixon
bind '"\C-s":nop'
bind '"\C-sf":nop'
bind '"\C-se":nop'
bind '"\C-sf":"tmux-sessionizer\n"'
bind '"\C-se":"tmux-session-selector\n"'
# - print yank
source ~/.local/bash/print_yank.bash
bind -x '"\C-l": print_yank'
# - enable Ctrl-q as Ctrl-v in vim
stty start undef
# ref: https://zhuanlan.zhihu.com/p/34509032
# "\C-m" is sames as EOL
#}}}
#{{{ git config
git() { if [[ $@ == "pull" ]]; then command echo "Instead of pull, using > git fetch --all -p && git rebase"; else command git "$@"; fi; }
git config --global core.editor "vim"
git config --global core.pager "less -S"
# - ref: https://www.youtube.com/watch?v=aolI_Rz0ZqY&t=905s
git config --global user.name "Wen-Jie Li"
git config --global user.email "jnjn0022@gmail.com"
git config --global http.proxy "http://cache1:3128"
git config --global http.postBuffer "524288000"
git config --global https.proxy "http://cache1:3128"
git config --global push.default simple
git config --global pull.rebase true
# - ref: https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/
git config --global alias.wt "worktree"
git config --global alias.root 'rev-parse --show-toplevel'
# :G ls
# :G ls %
# :G ls --grep=<pattern> --author=<author>
# --name-only
# --stat
# - ref: https://stackoverflow.com/questions/1441010/the-shortest-possible-output-from-git-log-containing-author-and-date
# > git ls/ll -n ${number}
# > git ls/ll --since="2week/2day"
# > git ls/ll --author="Wen-Jie"
# > git ls/ll -- ${filepath}
git config --global alias.ls "log --decorate --oneline --graph --reflog"
git config --global alias.ll "log --decorate --oneline --graph --reflog --date=format:%Y-%m-%d\ %H:%M --pretty=tformat:'%C(auto,yellow)%h %C(auto,blue)%ad %C(auto,green)%<(7,trunc)%aN%C(reset)%C(auto)%d%C(reset) %s'"
git config --global alias.rl "reflog --pretty=tformat:'%Cred%h%Creset %C(yellow)%gd%C(reset) %C(auto)%gs%C(reset) %C(green)(%cr)%C(reset) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.tree "log --graph --simplify-by-decoration --pretty=tformat:'%C(auto,blue)%cr%C(auto)%d' --all"
git config --global alias.ft "fetch --all -p"
# > git st -sb
git config --global alias.st "status"
git config --global alias.sb "st -sbuno"
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
git config --global rebase.rebaseMerges true
# do # obtain from the other file
# dp # put to the other file
# ]c # jump to the next diff
# [c # jump to the previous diff
git config --global merge.tool vim
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
git config --global diff.tool vimdiff
git config --global diff.algorithm myers
git config --global difftool.prompt false
mm() {
    remote_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo '');
    [ -z "${remote_branch}" ] && remote_branch="{L}"
    branch=$(git symbolic-ref --short -q HEAD 2>/dev/null || echo '')
    if [ -z "$branch" ]; then
        branch="(DETACHED)";
    else
        branch="$remote_branch $branch";
    fi;
    conflicted_files=$(git --no-pager diff --name-only --diff-filter=U 2>/dev/null | wc -l);
    conflicted_blocks=$(git diff --name-only --diff-filter=U 2>/dev/null | xargs grep -h '<<<<<<< ' 2>/dev/null | wc -l);
    commit=$(git rev-parse --short HEAD 2>/dev/null || echo 'UNKNOWN');
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0);
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0);
    staged=$(git diff --cached --name-only 2>/dev/null | wc -l);
    unstaged=$(git diff --name-only 2>/dev/null | wc -l);
    untracked=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l | tr -d ' ');
    stashed=$(git stash list 2>/dev/null | wc -l | tr -d ' ');
    if [ -f "$(git rev-parse --git-path rebase-merge/interactive 2>/dev/null)" ]; then status=" [REBASE-i]"
    elif [ -d "$(git rev-parse --git-path rebase-merge 2>/dev/null)" ]; then status=" [REBASE]"
    elif [ -d "$(git rev-parse --git-path rebase-apply 2>/dev/null)" ]; then status=" [REBASE]"
    elif [ -f "$(git rev-parse --git-path MERGE_HEAD 2>/dev/null)" ]; then status=" [MERGE]"
    fi
    echo -n "GIT $branch @$commit";
    [ "$ahead" != "0" ] && echo -n " ↑·$ahead";
    [ "$behind" != "0" ] && echo -n " ↓·$behind";
    echo " | A:$staged M:$unstaged U:$untracked S:$stashed X:$conflicted_files:$conflicted_blocks$status";
}

git_diff_with_abs_path() {
    local path

    path=$(git rev-parse --show-toplevel) &&
    git diff --name-only "$@" | sed "s,^,$path/,"
}
#}}}
#{{{ git prompt
# ref: https://blog.sasworkshops.com/showing-status-in-the-git-bash-prompt/
function parse_git_branch() {
     if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")
        local status=""

        if [ -n "$(git status --porcelain -uno 2>/dev/null)" ]; then
            status="*"
        fi

        echo "$branch$status"
    fi
}

RESET='\[\033[0m\]'
BLACK='\[\033[30m\]'
RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
BLUE='\[\033[34m\]'
MAGENTA='\[\033[35m\]'
CYAN='\[\033[36m\]'
WHITE='\[\033[37m\]'
BRIGHT_BLACK='\[\033[90m\]'
BRIGHT_RED='\[\033[91m\]'
BRIGHT_GREEN='\[\033[92m\]'
BRIGHT_YELLOW='\[\033[93m\]'
BRIGHT_BLUE='\[\033[94m\]'
BRIGHT_MAGENTA='\[\033[95m\]'
BRIGHT_CYAN='\[\033[96m\]'
BRIGHT_WHITE='\[\033[97m\]'

export PS1="${BRIGHT_GREEN}[\W] ${BRIGHT_BLUE}git:(${BRIGHT_RED}\$(parse_git_branch)${BRIGHT_BLUE}) \[\033[33m\][\j] $ ${RESET}"

## bash-git-promt config
#file="${HOME}/.local/lib/bash-git-prompt/gitprompt.sh"
#if [ -f ${file} ]; then
#    GIT_PROMPT_ONLY_IN_REPO=0
#    GIT_PROMPT_SHOW_UPSTREAM=1
#    GIT_PROMPT_FETCH_REMOTE_STATUS=1
#    GIT_PROMPT_IGNORE_SUBMODULES=1
#    GIT_PROMPT_START_ROOT="\[\033[33m\][\w]\[\033[0m\]"
#    GIT_PROMPT_START_USER="\[\033[33m\][\w]\[\033[0m\]"
#    GIT_PROMPT_END_ROOT=" \n\[\033[33m\][\j] > \[\033[0m\]"
#    GIT_PROMPT_END_USER=" \n\[\033[33m\][\j] > \[\033[0m\]"
#    source ${file}
#    #echo "Prompt ${file}"
##else
#    #echo "Prompt [Warning] ${file} not exist"
#fi
#}}}
#{{{ function

# - fzf config
#if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
#   export FZF_DEFAULT_OPTS='-m'
#fi

function yy () {
    if [[ $# != 1 ]]; then
        pwd | tr -d '\n' | yank
        echo "Yank: $(pwd)"
    else
        readlink -f $1 | tr -d '\n' | yank
        echo "Yank: $(pwd)/${1}"
    fi
}

# - ref: https://www.youtube.com/watch?v=F8dgIPYjvH8&ab_channel=AndrewCourter
# - ref: https://www.olafalders.com/2024/06/14/one-line-fuzzy-find-for-git-worktree/
function ff () {
#files -> tee ---> stdout ---------------> command-subst -> ${selection}
#              |-> pipe -> yank (stdin) -> yank's stdout
    selection="$(files | tee >(yank))"
    printf "Yank: %s" "${selection}"
}

function gg () {
#files -> tee ---> stdout ---------------> command-subst -> ${selection}
#              |-> pipe -> yank (stdin) -> yank's stdout
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        printf "Not inside a git repository\n"
        return
    fi
    selection="$(gfiles | tee >(yank))"
    printf "Yank: %s" "${selection}"
}

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

# - ref: https://github.com/junegunn/fzf.vim/issues/970
# - ref: https://junegunn.github.io/fzf/tips/ripgrep-integration/
# ripgrep->fzf->vim [QUERY]
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

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
#sudo apt install -y gcc wget iputils-ping python3-pip git bear tig shellcheck ripgrep
#
## 安装 neovim 的各种依赖 https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites
#sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
#brew install autossh
#curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
#gunzip terminfo.src.gz
#tic terminfo.src
#}}}
#{{{ eda tool config
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
#}}}




# - ref: https://github.com/andrew8088/dotfiles/blob/main/zsh/git.zsh
#!/bin/bash

# Copied from Gary Bernhardt (destroyallsoftware.com) dot files repository.
#
# Log output:
#
# * 51c333e    (12 days)    <Gary Bernhardt>   add vim-eunuch
#
# Branch output:
#
# * release/v1.1    (13 days)    <Leyan Lo>   add pretty_git_branch
#
# The time massaging regexes start with ^[^<]* because that ensures that they
# only operate before the first "<". That "<" will be the beginning of the
# author name, ensuring that we don't destroy anything in the commit message
# that looks like time.
#
# The log format uses } characters between each field, and `column` is later
# used to split on them. A } in the commit subject or any other field will
# break this.

LOG_HASH="%C(always,yellow)%h%C(always,reset)"
LOG_RELATIVE_TIME="%C(always,green)(%ar)%C(always,reset)"
LOG_AUTHOR="%C(always,blue)<%an>%C(always,reset)"
LOG_REFS="%C(always,red)%d%C(always,reset)"
LOG_SUBJECT="%s"

LOG_FORMAT="$LOG_HASH}$LOG_AUTHOR}$LOG_RELATIVE_TIME}$LOG_SUBJECT $LOG_REFS"

BRANCH_PREFIX="%(HEAD)"
BRANCH_REF="%(color:red)%(color:bold)%(refname:short)%(color:reset)"
BRANCH_HASH="%(color:yellow)%(objectname:short)%(color:reset)"
BRANCH_DATE="%(color:green)(%(committerdate:relative))%(color:reset)"
BRANCH_AUTHOR="%(color:blue)%(color:bold)<%(authorname)>%(color:reset)"
BRANCH_CONTENTS="%(contents:subject)"

BRANCH_FORMAT="}$BRANCH_PREFIX}$BRANCH_REF}$BRANCH_HASH}$BRANCH_DATE}$BRANCH_AUTHOR}$BRANCH_CONTENTS"

show_git_head() {
    pretty_git_log -1
    git show -p --pretty="tformat:"
}

pretty_git_log() {
    git log --since="1 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}

pretty_git_log_long() {
    git log --since="12 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}

pretty_git_log_all() {
    git log --all --since="12 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}


pretty_git_branch() {
    git branch -v --color=always --format=${BRANCH_FORMAT} $* | pretty_git_format
}

pretty_git_branch_sorted() {
    git branch -v --color=always --format=${BRANCH_FORMAT} --sort=-committerdate $* | pretty_git_format
}

pretty_git_format() {
    # Replace (2 years ago) with (2 years)
    sed -Ee 's/(^[^)]*) ago\)/\1)/' |
    # Replace (2 years, 5 months) with (2 years)
    sed -Ee 's/(^[^)]*), [[:digit:]]+ .*months?\)/\1)/' |
    # Shorten time
    sed -Ee 's/ seconds?\)/s\)/' |
    sed -Ee 's/ minutes?\)/m\)/' |
    sed -Ee 's/ hours?\)/h\)/' |
    sed -Ee 's/ days?\)/d\)/' |
    sed -Ee 's/ weeks?\)/w\)/' |
    sed -Ee 's/ months?\)/M\)/' |
    # Shorten names
    sed -Ee $'s/\033\\[34m<Andrew Burgess>/\033[31m<me>/' |
    sed -Ee 's/<([^ >]+) [^>]*>/<\1>/' |
    # Line columns up based on } delimiter
    column -s '}' -t
}

git_page_maybe() {
    # Page only if we're asked to.
    if [ -n "${GIT_NO_PAGER}" ]; then
        cat
    else
        # Page only if needed.
        less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines
    fi
}
