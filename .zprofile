export EDITOR=$(command -v nvim >/dev/null 2>&1 && echo nvim || echo vim)
export VISUAL="$EDITOR"

# Add private bins to PATH
typeset -U path
if [ -d "$HOME/bin" ] ; then
    path=("$HOME/bin" $path)
fi

if [ -d "$HOME/.local/bin" ] ; then
    path=("$HOME/.local/bin" $path)
fi

if [ -d "$HOME/.opencode/bin" ] ; then
    path=("$HOME/.opencode/bin" $path)
fi
