#!/bin/bash -e

# TODO: script should only be executed from this directory
# ${BASH_SOURCE[0]}

# list of target dotfiles (paths to their target directories)
dotfiles=(~/.bashrc ~/.profile ~/.inputrc ~/.vimrc ~/.gitconfig ~/.tmux.conf ~/.config/Code/User/settings.json ~/.config/user-dirs.dirs)
for dotfile in ${dotfiles[@]}; do
    # determine local dotfile (path to this directory)
    _dotfile=$(realpath $(basename $dotfile))

    # check if target dotfile exists
    if [ -f $dotfile ]; then
        if [ $(realpath $dotfile) = $_dotfile ]; then
            echo "$dotfile already linked"
        else
            read -p "$dotfile exists, override? (y/n): " res
            if [ -n $res -a \( "$res" = "y" -o "$res" = "Y" \) ]; then
                ln -sf $_dotfile $dotfile
            fi
        fi
    else
        echo "$dotfile does not exist, link it"
        mkdir -p $(dirname $dotfile)
        ln -sf $_dotfile $dotfile
    fi
done

# install apt packages
#cat packages.txt | xargs sudo apt install
