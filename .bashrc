# ls aliases

#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'
#alias c='clear'

# ls -> exa binding
alias ls='exa -al --color=always --group-directories-first' 
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# custom aliases
alias SS='source venv/bin/activate'
alias ..='cd ..'
alias c='clear'
alias ssa='sudo su -l {user}'

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# nala -> apt binding
apt() {
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

# display git branch
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# vim and emacs
alias em="/usr/bin/emacs -nw"

RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
NO_COLOR="\[\033[00m\]"

PS1="$GREEN\u@\h$NO_COLOR:$BLUE\w$YELLOW\$(git_branch)$NO_COLOR\$ "

