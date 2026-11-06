_prepend_path() {
    if [ -d "$1" ]; then
	case ":$PATH:" in
	    *":$1:"*) ;; # Already in PATH
	    *) PATH="$1:$PATH" ;;
	esac
    fi
}

# Add private bins to PATH
_prepend_path "$HOME/bin"
_prepend_path "$HOME/.local/bin"
_prepend_path "$HOME/.opencode/bin"

unset -f _prepend_path

export EDITOR=$(command -v nvim >/dev/null 2>&1 && echo nvim || echo vim)
export VISUAL="$EDITOR"
