# sudo apt install zsh
# chsh -s $(which zsh)
# man zshoptions

# Keybindings
bindkey -e # enable standard key bindings (e.g., ctrl+r for backward history search)
bindkey '^[[5~' history-beginning-search-backward  # start typing + [Up-Arrow] - fuzzy find history forward  
bindkey '^[[6~' history-beginning-search-forward   # start typing + [Down-Arrow] - fuzzy find history backward
bindkey '^[[1;5C' forward-word      # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word     # [Ctrl-LeftArrow] - move backward one word

# Command history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell
# setopt hist_save_no_dups  # Do not write a duplicate event to the history file.

# alias ls='ls -v --color=auto --group-directories-first --time-style=long-iso'
alias ls='ls -v --color=auto --group-directories-first'
alias ll='ls -lF'
alias la='ls -lAF'
alias l='ls -CF'
alias ..='cd ..'

# Directory stack (use cd -1 oldest first, or cd +1 newest first)
setopt auto_cd              # no need to type cd to jump into a directory, just type the directory and execute as a command
setopt auto_pushd           # push the current directory visited on the stack
setopt pushd_ignore_dups    # do not store duplicates in the stack
setopt pushd_silent         # do not print the directory stack after pushd or popd

# Auto-completion (type zstyle to list currently active zstyle options)
autoload -U compinit; compinit  # enable auto-completion
# _comp_options+=(globdots)     # include hidden files in auto-completion
# setopt MENU_COMPLETE          # insert first match immediately
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' menu select # select completions with arrow keys
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Load starship prompt (sudo snap install starship, sudo apt install fonts-powerline)
eval "$(starship init zsh)"

# Enable auto-suggestion (sudo apt install zsh-autosuggestions)
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable syntax highlighting (sudo apt install zsh-syntax-highlighting)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable command not found suggestions (sudo apt install command-not-found)
source /etc/zsh_command_not_found