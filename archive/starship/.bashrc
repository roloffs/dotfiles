# activate starship prompt
if [ -x /snap/bin/starship ]; then
   cd ~ &> /dev/null
   eval "$(starship init bash)"
   cd - &> /dev/null
fi
