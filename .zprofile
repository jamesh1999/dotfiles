export EDITOR=$(command -v nvim >/dev/null 2>&1 && echo nvim || echo vim)
export VISUAL="$EDITOR"

# Add private bins to PATH
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi
