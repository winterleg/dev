export ZSH="$HOME/.oh-my-zsh"

export GPG_TTY=$(tty)

export EDITOR="nvim"
export VISUAL="$EDITOR"
export MAKEFLAGS="-j12"
export NPROCESSORS_CONF="12"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/Desktop/dev/scripts:$PATH"
export PATH="$HOME/.cargo/bin/:$PATH"

export WORKSTATION="$HOME/Desktop/dev"


# if [[ "$TERM" == "kmscon" ]]; then
#   nvim ~
# fi

ZSH_THEME="robbyrussell"

plugins=(
    git
    fzf-tab
    battery
    vi-mode
)

source $ZSH/oh-my-zsh.sh


[ -f ~/.aliases.sh ] && source ~/.aliases.sh

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{cyan}[%f%F{red}%b%f%F{cyan}]%f'

setopt PROMPT_SUBST
PROMPT='[%~] %F{green}>%f '

# bindkey -s ^t "^utmux-goway\n"
bindkey -s ^f "^uvfz\n"

zstyle ':completion:*:(vim|nvim):*' ignored-patterns '*.pdf'

_twink() {
  _files -g '*.typ'
}

compdef _twink twink
_tmux-goway() {
    _files -/
}
compdef _tmux-goway tmux-goway

# setxkbmap ca > /dev/null 2>&1

[ -f "/home/fuyu147/.ghcup/env" ] && . "/home/fuyu147/.ghcup/env" # ghcup-env
[[ ! -r '/home/fuyu147/.opam/opam-init/init.zsh' ]] || source '/home/fuyu147/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/fuyu147/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/home/fuyu147/.julia/juliaup/completions/zsh.zsh" ] && source "/home/fuyu147/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<

export PATH=$PATH:/home/hiver/.spicetify

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    eval "$(ssh-agent -s)" >/dev/null
fi

if ! ssh-add -l 2>/dev/null | grep -q "$(ssh-keygen -lf ~/id-cb-g 2>/dev/null | awk '{print $2}')"; then
    ssh-add ~/id-cb-g
fi

