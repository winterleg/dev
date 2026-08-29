alias mrg="doas emerge"

world() {
	doas emaint -a sync
	doas emerge -avuDN @world
}

alias vim="nvim -u ~/.config/nvim/init-min.lua"
alias vi="vim"
alias rs="nvim"

alias ff="fastfetch"

alias calendar="cal -n 3"

alias ls="eza --no-quotes -s type -a"

# alias t="tmux-goway"
alias t="tmux"
alias ta="tmux a"

alias e="exit"
alias q="exit"
alias wq="exit"
alias r="yazi"
alias ..="cd .."
alias rel="omz reload"

alias g="git"
alias gs="git status"
alias ga="git add ."
alias gd="git diff"
alias gc="git commit"
alias gcm="git commit -m"
alias gac="git commit -a"
alias gacm="git commit -am"
alias gpush="git push"
alias gpull="git pull"
alias gl="git log --graph --stat"
alias glp="git log --graph --stat -p"
alias glw="git log --oneline --graph --decorate --all"

alias maple="~/maple2022/bin/xmaple"

yt-mpv() {
  local tmp_dir=$(mktemp -d)
  ~/repos/yt-dlp/yt-dlp.sh -f "bv[height>=720]+ba" -o "$tmp_dir/video.%(ext)s" "$1"
  mpv "$tmp_dir/video".*
  rm -rf "$tmp_dir"
}

yt-extract-audio() {
  ~/repos/yt-dlp/yt-dlp.sh "$1" -x --audio-format mp3
}

psk() {
  for str in "$@"; do
    printf "%-15s %.2f GB\n" "$str" "$(ps -o rss= -p $(pgrep $str) | awk '{s+=$1} END {print s / (1024*1024)}')"
  done
}

open() {
  xdg-open $1 >/dev/null 2>&1 &
  disown
}

battery() {
  upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
    awk '/state:/ { s=$2 } /percentage:/ { p=$2 } END { print p " (" s ")" }'
}

range() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"

  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd -- "$cwd"
  rm -f -- "$tmp"
}
