#{{{ wsl
# https://www.youtube.com/watch?v=mSXOYhfDFYo
# wsl --install Ubuntu
# wsl --unregister Ubuntu
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
#{{{ X11 and ssH
# In CentOS (remote-linux)
# 1. > sudo yum update -y
# 2. > sudo yum install libX11
# 3. type the following ong the sshd_config file which need root authority
# In vim /etc/ssh/sshd_config
# X11Forwarding yes
# X11DisplayOffset 10
# X11UseLocalhost yes
# systemctl restart sshd

# # Create ~/.Xauthority Has Been Created
# In remote server (remote-linux)
# 1. > xauth list
export XAUTHORITY=$HOME/.Xauthority

# # Easy Wat to Access ssh from ssh -Y jasonli@atcpcw10: 22 to ssh r10
# In wezterm
# In C:/Users/jasonli/.ssh/config (local-window)
# 1. type the following on the config file
# Host r10
#     HostName atcpcw10
#     User jasonli
#     Port 22
#     ForwardX11 yes
#     ForwardX11Trusted yes
#     IdentitiesOnly yes
# 2. > ssh r10

# # Auto Login without Password
# In wezterm
# In C:/Users/jasonli/.ssh/config (local-window)
# 1. > ssh-keygen
# 2. > type id_ed25519.pub | ssh jasonli@atcpcw10 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

# # Login with Different Method
# ## Method1: wezterm + mobaxterm (local-window) (recommand)
# In mobaxterm
# 1. > wezterm
# In wezterm
# 1. ssh -Y jasonli@atcpcw10 -p 22
# 1. ssh r10

# ## Method2: wezterm (locol-window)
# ref: https://stackoverflow.com/questions/65468655/vs-code-remote-x11-cant-get-display-while-connecting-to-remote-server
# ref: https://wiki.iihe.ac.be/Use_SSH_%26_X11_forwarding_on_Windows
# In remote server (remote-linux)
# 1. > xauth list
# to create ~/.Xauthority
# remind ${number} which is 49 in Xauthority
# notice that 49 can be different number
# In VcXsrv (local-window)
# 1. tick Multiple windows
# 2. type Display number: ${number}
# 3. tick Start no Client
# 4. tick Disable access control
# In wezterm
# 1. > set DISPLAY=localhost:${number}.0
# 2. ssh -Y jasonli@atcpcw10 -p 22
# 2. ssh r10

# # fix $DISPLAY when ssh reconnect with tmux mode
# ref: https://www.reddit.com/r/ssh/comments/1aurs0x/ssh_x_forwarding_for_active_tmux_session/
function fix_tmuxenv() {
    eval $(tmux show-environment | sed -e '/^-/d' -e "s/'/'\\\"/g" -e "s/=\(.*\)/='\\1'/" -e "s/^/export /g")
}

# # test osc52
function test_osc52() {
    local msg="OSC52 SUCCESS!!"
    local b64
    b64=$(echo -n "$msg" | base64)
    printf "\033Ptmux;\033\033]52;c;%s\007\033\\" "$b64"
}
#}}}
#{{{ export
# # language config
# ref: https://samwhelp.github.io/note-ubuntu-18.04/read/howto/install/locale/
# > locale -a
# > locale
# if en_US.utf-8 does not exist
# > sudo locale-gen en_US.UTF-8
export LANG="en_US.utf-8"
export LC_ALL=

# # set $TERM
# ref: https://unix.stackexchange.com/questions/574669/clearing-tmux-terminal-throws-error-tmux-256color-unknown-terminal-type
# > infocmp -x xterm-256color > saved
# > tic -x saved
# check terminfo
# > infocmp tmux-256color
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi

# set $PATH
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.local/script:${PATH}"
#}}}
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
# ref: https://superuser.com/questions/1786563/how-do-i-run-a-bash-script-automatically-everytime-i-hit-ctrl-s
#stty stop ''
#bind '"\C-s":nop'
#bind '"\C-sf":nop'
#bind '"\C-se":nop'
bind '"\C-af":"tmux-sessionizer\n"'
bind '"\C-ae":"tmux-session-selector\n"'
#}}}
#{{{ git config
# ref: https://www.youtube.com/watch?v=aolI_Rz0ZqY&t=905s
git config --global user.name "Wen-Jie Li"
git config --global user.email "jnjn0022@gmail.com"
git config --global http.proxy "http://cache1:3128"
git config --global http.postBuffer "524288000"
git config --global https.proxy "http://cache1:3128"
git config --global push.default simple
git config --global pull.rebase true
# ref: https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/
git config --global alias.wt "worktree"
git config --global alias.root 'rev-parse --show-toplevel'
# :G ls
# :G ls %
# :G ls --grep=<pattern> --author=<author>
# --name-only
# --stat
# ref: https://stackoverflow.com/questions/1441010/the-shortest-possible-output-from-git-log-containing-author-and-date
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
git config --global alias.ss \
"!f() { \
remote_branch=\$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo ''); \
[ -n \"\$remote_branch\" ] && remote_branch=\"{\$remote_branch}\"; \
branch=\$(git symbolic-ref --short -q HEAD 2>/dev/null); \
if [ -z \"\$branch\" ]; then \
    branch=\"(DETACHED)\"; \
else \
    branch=\"\$remote_branch \$branch\"; \
fi; \
[ -d .git/MERGE_HEAD ] && merge=\"[MERGING]\"; \
commit=\$(git rev-parse --short HEAD 2>/dev/null || echo 'unknown'); \
ahead=\$(git rev-list --count @{u}..HEAD 2>/dev/null || echo 0); \
behind=\$(git rev-list --count HEAD..@{u} 2>/dev/null || echo 0); \
staged=\$(git diff --cached --name-only | wc -l | tr -d ' '); \
unstaged=\$(git diff --name-only | wc -l | tr -d ' '); \
modified=\$(git status --porcelain | grep '^ M' | wc -l | tr -d ' '); \
untracked=\$(git status --porcelain | grep '^??' | wc -l | tr -d ' '); \
stash=\$(git stash list | wc -l | tr -d ' '); \
echo -n \"GIT \$branch @\$commit\"; \
if [ \"\$ahead\" != \"0\" ] || [ \"\$behind\" != \"0\" ]; then \
    echo -n \" ↑\$ahead ↓\$behind\"; \
fi; \
echo -n \" | A:\$staged M:\$unstaged U:\$untracked S:\$stash\"; \
echo -n \" \$merge\"; \
echo \"\"; \
}; f"

git-diff-with-abs-path() {
    local path

    path=$(git rev-parse --show-toplevel) &&
    git diff --name-only "$@" | sed "s,^,$path/,"
}
#}}}
#{{{ git prompt
# ref: https://blog.sasworkshops.com/showing-status-in-the-git-bash-prompt/
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
#{{{ function
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

# ref: https://www.youtube.com/watch?v=F8dgIPYjvH8&ab_channel=AndrewCourter
# > fd | fzf
# > cd $(fd | fzf)
function ff () {
    selection="$(fd | fzf | tr -d '\n')"
    selection="$(pwd)/${selection}"
    echo "${selection}" | tr -d '\n' |xsel -i -b
    echo "pp $(cout)"
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

#function cdw () {
#    cd "$(git worktree list | fzf | awk '{print $1}')"
#}

#function fb () {
#    selection="$(git worktree list | fzf | awk '{print $1}')"
#
#    echo "${selection}" | tr -d '\n' |xsel -i -b
#    echo "Copy to clipboard: $(cout)"
#}

# ref: https://www.olafalders.com/2024/06/14/one-line-fuzzy-find-for-git-worktree/
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
