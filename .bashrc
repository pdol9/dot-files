# See bash(1) for more options
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# ******************** prompt *************************** #

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi

# disable TMP

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac
#-------------------------------

# BASH PROMPT

# Define some basic colors using tput (8-bit color: 256 colors)
red="\[$(tput setaf 160)\]"
bright_red="\[$(tput setaf 196)\]"
light_purple="\[$(tput setaf 60)\]"
orange="\[$(tput setaf 172)\]"
blue="\[$(tput setaf 21)\]"
light_blue="\[$(tput setaf 80)\]"
bold="\[$(tput bold)\]"
reset="\[$(tput sgr0)\]"

# Define basic colors to be used in prompt
## The color for username (light_blue, for root user: bright_red)
username_color="${reset}${bold}${light_blue}\$([[ \${EUID} == 0 ]] && echo \"${light_purple}\")";
## Color for git branch (orange)
git_branch_color=$reset$orange
## Color of @ and ✗ symbols (orange)
at_color=$reset$bold$light_purple
## Color of host/pc-name (blue)
host_color=$reset$bold$light_blue
## Color of current working directory (light_purple)
directory_color=$reset$light_purple
## Color for other characters (like the arrow)
etc_color=$reset$light_blue
# If last operation did not succeed, add [✗]- to the prompt
on_error="\$( echo \"${etc_color}[${at_color}\$?${etc_color}]─\")"

# Function to retrieve the current git branch
git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    echo "(${branch})"
  fi
}

# The last symbol in the prompt ($, for root user: #)
symbol="${reset}${bold}${light_purple}$(if [[ ${EUID} == 0 ]]; then echo '# '; else echo '$ '; fi)"

# Setup the prompt/prefix for the Linux terminal
PS1="${etc_color}┌─${on_error}["
PS1+="${username_color}\u" # \u=Username
PS1+="${at_color}@"
PS1+="${host_color}\h" #\h=Host
PS1+="${etc_color}]-["
PS1+="${directory_color}\w" # \w=Working directory
PS1+="${etc_color}]"
PS1+="${git_branch_color}"
PS1+="\$(git_branch)" # Append git branch
PS1+="${etc_color}" # \n=New Line
PS1+="\n└──╼ " # \n=New Line
PS1+="${symbol}${reset}"

export PS1

# create a new directory
ND () {
  mkdir -p "$1" && cd "$1"
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# rust cargo
. "$HOME/.cargo/env"

export PATH=$PATH:~/.vim/plugged/vim-iced/bin
