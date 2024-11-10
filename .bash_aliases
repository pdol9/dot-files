# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#	 #alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

# create a new directory
ND () {
  mkdir -p "$1" && cd "$1"
}

alias ls='exa -a --color=always --group-directories-first'
alias la='exa -al --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'
alias li='exa --icons -a --group-directories-first'

# custom aliases
alias SS='source venv/bin/activate'
alias ..='cd ..'
alias c='clear'
alias vvM='qemu-system-x86_64 --enable-kvm -m 4512 -hda myvm.qcow2'
alias ZZ='rustc'
alias PP='python3'
alias vi='vim'
alias nv='nvim'
alias por='sh /home/usr/bin/lin-portacle/portacle/portacle.run'
alias gitL="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
