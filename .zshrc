#zmodload zsh/zprof
# Load the Antidote plugin manager
source ~/.antidote/antidote.zsh
antidote load

# Settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# Kill all background tasks
killjobs () {

    local kill_list="$(jobs)"
    if [ -n "$kill_list" ]; then
        # this runs the shell builtin kill, not unix kill, otherwise jobspecs cannot be killed
        # the `$@` list must not be quoted to allow one to pass any number parameters into the kill
        # the kill list must not be quoted to allow the shell builtin kill to recognise them as jobspec parameters
        kill $@ $(sed --regexp-extended --quiet 's/\[([[:digit:]]+)\].*/%\1/gp' <<< "$kill_list" | tr '\n' ' ')
    else
        return 0
    fi

}

# No arguments: 'git status'
# With arguments: like an alias of 'git'
g() {
	if [[ $# -gt 0 ]]; then
		git "$@"
	else
		git status
	fi
}

# Run VS Code in the background
# No arguments: 'code .'
# With arguments: as normal
code() {
  local TMP_DIR="${XDG_RUNTIME_DIR:-/tmp}/vscode-tmux"
  mkdir -p "$TMP_DIR"

  if [[ -n "$TMUX" ]]; then
    local TMUX_SESSION TMUX_WINDOW
    TMUX_SESSION=$(tmux display-message -p '#S')
    TMUX_WINDOW=$(tmux display-message -p '#I')

    echo "$TMUX_SESSION:$TMUX_WINDOW" > "$TMP_DIR/$(basename "$PWD").context"
  fi

  /usr/bin/code "${@:-.}" &!
}


# Easier nix build + docker load
nix-docker() {
  nix build "$1" && ./result | docker load
}


# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[5m'     # begin blink
export LESS_TERMCAP_md=$'\e[1;34m'     # begin bold
export LESS_TERMCAP_so=$'\e[01;46;30m' # begin reverse video
export LESS_TERMCAP_us=$'\e[4;35m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1

export MANPAGER='less -M +Gg'

export FZF_DEFAULT_OPTS="--tmux bottom,100%,40% --color=hl:13,hl+:13,info:4,pointer:4,spinner:13 --prompt='❯❯ ' --no-separator --highlight-line"

# Aliases
alias ra='ranger'
alias rcd='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias dr='direnv reload'
alias ls='eza'
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias cls='clear'
alias tm='tmux'
alias exitf='killjobs; exit'
alias myip='curl http://ipecho.net/plain; echo'
alias df='df --human-readable --print-type'
alias du='du --human-readable --total'
alias sudo='sudo '

eval "$(direnv hook zsh)"
source <(fzf --zsh)

autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
compdef g='git'


eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json)"
eval "$(zoxide init --cmd cd zsh)"

bindkey '^ ' autosuggest-accept # ctrl+space
#zprof
