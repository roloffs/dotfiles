# fzf key-bindings (ctrl+t search files, ctrl+r search history)
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

# fzf auto-completion (triggered by **)
if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
    . /usr/share/doc/fzf/examples/completion.bash
fi
