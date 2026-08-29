#/bin/sh

output=$(i3-msg -t get_workspaces |
    jq -r '.[] | select(.focused).output')

monitor=$(xrandr --listactivemonitors |
    awk -v output="$output" '
        index($0, output) {
            sub(":", "", $1)
            print $1
            exit
        }
    ')

exec dmenu_run -m "$monitor"
