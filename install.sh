#!/bin/sh
set -eu

# Install essential tools.
# sudo apt-get install -y vim git tig tree htop meld colordiff

# Download git-prompt.sh.
wget -q https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh

# List of dotfiles to be installed.
dotfiles="\
    ~/.bashrc \
    ~/.profile \
    ~/.inputrc \
    ~/.vimrc \
    ~/.gitconfig \
    ~/.gitignore \
    ~/.config/user-dirs.dirs \
    ~/.config/Code/User/settings.json \
"

installed=".installed"

for dotfile in $dotfiles; do
    # Determine target path of dotfile.
    target_path=$(echo "$dotfile" | sed "s|~|$HOME|g")

    # Determine source path of dotfile.
    source_path=$(find profile -maxdepth 1 -name "$(basename "$dotfile")")

    # Check if source dotfile exists.
    if [ ! -f "$source_path" ]; then
        echo "'$source_path' not found"
        continue
    fi

    # Check if target dotfile exists.
    if [ ! -f "$target_path" ]; then
        echo "'$target_path' does not exist, link it"
        mkdir -p "$(dirname "$target_path")"
        ln -f "$source_path" "$target_path"
        continue
    fi

    # Determine inodes of source and target dotfiles.
    target_inode=$(stat -c %i "$target_path")
    source_inode=$(stat -c %i "$source_path")

    # Check if inodes are equal.
    if [ $target_inode = $source_inode ]; then
        echo "'$target_path' already linked"
        continue
    fi

    # Check if dotfile is already installed.
    if grep -qw "$(basename "$dotfile")" "$installed"; then
        echo "'$target_path' got unlinked, link it"
        ln -f "$source_path" "$target_path"
        continue
    fi

    # Install dotfile.
    echo "'$target_path' exists, create backup and link it"
    cp "$target_path" > "${source_path}.backup"
    echo "$target_path" >> "$installed"
    ln -f "$source_path" "$target_path"
done
