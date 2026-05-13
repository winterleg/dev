export ZSH="$HOME/.oh-my-zsh"

export GPG_TTY=$(tty)

export EDITOR="nvim"
export VISUAL="$EDITOR"
export MAKEFLAGS="-j12"
export NPROCESSORS_CONF="12"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$PATH"

export WORKSTATION="$HOME/dotfiles"

ZSH_THEME="robbyrussell"

plugins=(
    git
    fzf-tab
    battery
)

source $ZSH/oh-my-zsh.sh


[ -f ~/.aliases.sh ] && source ~/.aliases.sh

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{cyan}[%f%F{red}%b%f%F{cyan}]%f'

setopt PROMPT_SUBST
# %F{yellow};%f
# PROMPT='%(?.%F{green}>.%F{red}>)%f %F{cyan}[%f%F{blue}%~%f%F{cyan}]%f${vcs_info_msg_0_}
# %F{yellow}%%%f '
# PROMPT='%(?.%F{green}::.%F{red}::)%f %F{cyan}[%f%F{blue}%~%f%F{cyan}]%f${vcs_info_msg_0_}
#  %F{yellow}>%f '
# PROMPT='${vcs_info_msg_0_} %(?.%F{green}::.%F{red}::)%f '
PROMPT='%(?.%F{green}λ.%F{red}λ)%f '

bindkey -s ^t "^utmux-goway\n"
bindkey -s ^y "^uyazi-tmux\n"
bindkey -s ^f "^uvfz\n"
bindkey -s ^q "^ukitty sh -c ranger\n"

zstyle ':completion:*:(vim|nvim):*' ignored-patterns '*.pdf'

_twink() {
  _files -g '*.typ'
}

compdef _twink twink
_tmux-goway() {
    _files -/
}
compdef _tmux-goway tmux-goway

setxkbmap ca > /dev/null 2>&1

[ -f "/home/fuyu147/.ghcup/env" ] && . "/home/fuyu147/.ghcup/env" # ghcup-env
[[ ! -r '/home/fuyu147/.opam/opam-init/init.zsh' ]] || source '/home/fuyu147/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
