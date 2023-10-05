#!/bin/sh
set -eu

# install essential tools
# sudo apt-get install -y vim tree htop colordiff

# download git-prompt.sh
wget -q -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# list of dotfiles to be installed
dotfiles="\
    ~/.bashrc \
    ~/.profile \
    ~/.inputrc \
    ~/.vimrc \
    ~/.gitconfig \
    ~/.config/Code/User/settings.json \
"

for dotfile in $dotfiles; do
    # determine target path of dotfile
    target_path=$(echo "$dotfile" | sed "s|~|$HOME|g")

    # determine source path of dotfile
    source_path=$(find profile -maxdepth 1 -name "$(basename "$target_path")")

    # check if source dotfile exists
    if [ ! -f "$source_path" ]; then
        echo "'$source_path' not found"
        continue
    fi

    # check if target dotfile exists
    if [ ! -f "$target_path" ]; then
        echo "'$target_path' does not exist, link it"
        mkdir -p "$(dirname "$target_path")"
        ln -f "$source_path" "$target_path"
        continue
    fi

    # determine inodes of source and target dotfiles
    target_inode=$(stat -c %i "$target_path")
    source_inode=$(stat -c %i "$source_path")

    # check if inodes are equal
    if [ $target_inode = $source_inode ]; then
        echo "'$target_path' already linked"
    else
        read -p "'$target_path' exists, override? (y/n): " res
        if [ "$res" = y -o "$res" = Y ]; then
            file_diff=$(diff -u "$source_path" "$target_path" || true)
            if [ -n "$file_diff" ]; then
                echo "$file_diff" > "${source_path}.patch"
            fi
            # patch -u "$source_path" -i "${source_path}.patch"
            ln -f "$source_path" "$target_path"
        fi
    fi
done
