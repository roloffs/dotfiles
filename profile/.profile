# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# basic environment variables
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# mouse scrolling in less
#export LESS='-R'

# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m' # start bold
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;34m' # start standout
#export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m' # start underline
export LESS_TERMCAP_ue=$'\e[0m'

# Proxy server
#export http_proxy="http://<proxy.com:port>"
#export https_proxy="http://<proxy.com:port>"
#export ftp_proxy="http://<proxy.com:port>"
#export HTTP_PROXY=$http_proxy
#export HTTPS_PROXY=$https_proxy
#export FTP_PROXY=$ftp_proxy

PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.local/go/bin:$PATH"
PATH="$HOME/.local/flutter/bin:$PATH"
PATH="$HOME/.pub-cache/bin:$PATH"
PATH="$HOME/.pyenv/bin:$PATH"
