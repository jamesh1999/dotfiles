if [[ -n "$ZSH_PROFILE" ]]; then
  zmodload zsh/zprof
fi



# Env Vars
# --------
# Larger history
export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE

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

export BAT_THEME='Nord'

export FZF_DEFAULT_OPTS="--tmux bottom,100%,40% --color=hl:13,hl+:13,info:4,pointer:4,spinner:13 --prompt='❯❯ ' --no-separator --highlight-line --layout=reverse-list"
export FZF_CTRL_T_OPTS="--preview='bat -n --color=always {}'"

export PATH=/home/james/.opencode/bin:$PATH

export ZVM_INIT_MODE=sourcing  # Prevents zvm overriding other keybindings


# Plugins
# -------
# Load plugins via the Antidote plugin manager
source ~/.antidote/antidote.zsh
antidote load



# Options
# -------
setopt share_history
setopt hist_verify
setopt hist_ignore_space
setopt hist_ignore_all_dups



# Functions
# ---------
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
  command git "${@:-status}"
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



# Aliases
# -------
# Shorthands
alias ra='ranger'
alias rcd='ranger --choosedir=$HOME/.rangerdir; cd "$(cat $HOME/.rangerdir)"'
alias dr='direnv reload'
alias cls='clear'
alias tm='tmux'
alias lzd='lazydocker'
alias lzg='lazygit'

# Prettier output
alias ls='eza --icons=auto'
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias df='df --human-readable --print-type'
alias du='du --human-readable --total'

alias sudo='sudo ' # Make 'sudo {alias}' work
alias exitf='killjobs; exit'
alias myip='curl http://ipecho.net/plain; echo'



# Integrations
# ------------
eval "$(direnv hook zsh)"
eval "$(thefuck --alias)"
eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json)"
eval "$(zoxide init --cmd cd zsh)"



# Keybinds
# --------
bindkey '^ ' autosuggest-accept # ctrl+space
bindkey '^[[A' history-search-backward # up arrow
bindkey '^[[B' history-search-forward # down arrow



# Completions
# -----------
# Initialise completions as late as possible - we don't want anything modifying completions after this
autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
compdef g='git'
compdef tm='tmux'



if [[ -n "$ZSH_PROFILE" ]]; then
  zprof
fi
