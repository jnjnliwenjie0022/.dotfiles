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
