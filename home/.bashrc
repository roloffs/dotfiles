# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE="$HOME/.bash_history_"
HISTSIZE=200000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

__start=0
__elapsed=0

__elapsed_time() {
    local elapsed=$(echo "$__elapsed / 1000000000" | bc -l) # elapsed time in s
    LC_NUMERIC=C printf "[%.3f s] " $elapsed
}

__exit_code() {
    local ret=${PIPESTATUS[-1]}
    if [ $ret != 0 ]; then
        local nam=$(kill -l $ret 2> /dev/null)
        if [ -n "$nam" ]; then
            printf " %s (SIG%s) " $ret $nam
        else
            printf " %s " $ret
        fi
    fi
}

if [ "$color_prompt" = yes ]; then
    PS0='${__start:0:$((__start=$(date +%s%N),0))}'
    PS1='${__elapsed:0:$((__elapsed=$([ $__start != 0 ] && echo $(($(date +%s%N) - $__start)) || echo $__elapsed),0))}${debian_chroot:+($debian_chroot)}\[\e[0;37m\]$(__elapsed_time)\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0;31m\]$(__git_ps1)\[\e[1;33m\]$(__exit_code)\[\e[0m\]${__start:0:$((__start=0,0))}\$ '
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -v --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable colored diff version
if [ -x /usr/bin/colordiff ]; then
    alias diff='colordiff -u'
fi

# some python scripts
if [ -x /usr/bin/python3 ]; then
    # decimal to binary number conversion (dec2bin 4711 32)
    dec2bin() {
        python3 -c "print('{0:0${2:-8}b}'.format(${1:-0}))"
    }

    # decimal to binary ip address conversion (ip2bin 192.168.0.1)
    ip2bin() {
        python3 -c "print('.'.join(map(str,['{0:08b}'.format(int(x if x != '' else '0')) for x in '${1:-0.0.0.0}'.split('.')])))"
    }
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -lAF'
alias l='ls -CF'

# some cd aliases
alias +='pushd .'
alias -- -='popd'
alias ..='cd ..'

# pgrep alias
# alias pgrep='pgrep -fl'
# alias pkill='pkill -f'

# Add an "alert" alias for long running commands (sleep 10; alert)
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
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

# load git prompt
if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi
