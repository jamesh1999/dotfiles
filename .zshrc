#zmodload zsh/zprof
# Setup zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

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

# Aliases
alias ra='ranger'
alias rcd='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias dr='direnv reload'
alias ls='ls --color'
alias cls='clear'
alias tm='tmux'
alias exitf='killjobs; exit'
alias myip='curl http://ipecho.net/plain; echo'

eval "$(direnv hook zsh)"

autoload -Uz compinit; compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json)"
eval "$(zoxide init --cmd cd zsh)"

# Plugins
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start; \
 	bindkey '^ ' autosuggest-accept" \
    zsh-users/zsh-autosuggestions

#bindkey '^ ' autosuggest-accept # ctrl+space
#zprof
