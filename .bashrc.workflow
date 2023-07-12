# workspace config
alias vim="nvim -O"
alias tmux="tmux -u"
alias rebash='source ~/.bashrc'; echo "source ~/.bashrc"
export PATH="~/.local/bin:${PATH}"
PS1="\[\033[35m\][\t] \[\033[32m\][\w] \n\[\033[1;33m\][\j] > \[\033[0m\]"
if [ "$TERM" != "xterm-256color" ]; then
      export TERM=xterm-256color
fi

if type rg &> /dev/null; then
   	export FZF_DEFAULT_COMMAND='find $(cd ..; pwd)'
  	export FZF_DEFAULT_OPTS='-m'
fi
