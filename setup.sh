#!/usr/bin/env bash

# exit on error
set -e

# determine script directory
script_dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

# install basic tools
# sudo apt install -y vim htop meld colordiff

# install terminal tools
# i3, alacritty, tmux, ranger, zsh, fzf

# install dev tools
# code, pycharm, clion, eclipse

# list of target dotfiles (paths to their target locations)
dotfiles=( \
    ~/.vimrc \
    ~/.bashrc \
    ~/.profile \
    ~/.inputrc \
    ~/.gitconfig \
    ~/.tmux.conf \
    ~/.config/user-dirs.dirs \
    ~/.config/Code/User/settings.json \
)

for dst_dotfile in "${dotfiles[@]}"; do
    # resolve tilde symbol with home path in string
    dst_dotfile="${dst_dotfile/#\~/$HOME}"

    # find dotfile in current location
    src_dotfile="$(find "$script_dir" -name "$(basename "$dst_dotfile")" | head -n1)"
    if [[ "$src_dotfile" = "" ]]; then
        echo "'$(basename "$dst_dotfile")' not found"
        continue
    fi
    src_dotfile="$(readlink -f "$src_dotfile")"

    # check if dotfile exists in target location
    if [[ -f "$dst_dotfile" ]]; then
        if [[ "$(readlink -f "$dst_dotfile")" = "$src_dotfile" ]]; then
            echo "'$dst_dotfile' already linked"
        else
            read -p "'$dst_dotfile' exists, override? (y/n): " res
            if [[ "$res" != "" && ( "$res" = "y" || "$res" = "Y" ) ]]; then
                ln -sf "$src_dotfile" "$dst_dotfile"
            fi
        fi
    else
        echo "'$dst_dotfile' does not exist, link it"
        mkdir -p "$(dirname "$dst_dotfile")"
        ln -sf "$src_dotfile" "$dst_dotfile"
    fi
done
