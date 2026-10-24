
#!/bin/sh
set -eu

# Include common macOS Homebrew and user-local paths.
# export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/Homebrew/bin:/usr/local/Homebrew/sbin:/usr/local/bin:$PATH"

usage() {
    printf 'Usage: %s {terminal|kitty}\n' "$0" >&2
    exit 2
}

[ "$#" -eq 1 ] || usage

case "$1" in
    terminal|Terminal)
        terminal_app=1
        ;;
    kitty|Kitty)
        terminal_app=2
        ;;
    *)
        usage
        ;;
esac

tmux_bin=$(command -v tmux) || {
    printf 'Error: tmux not found in PATH\n' >&2
    exit 1
}

case "$terminal_app" in
    1)
        # Open macOS Terminal and attach to (or create) "main".
        exec osascript - "$tmux_bin" <<'APPLESCRIPT'
on run argv
    set tmuxPath to quoted form of (item 1 of argv)
    tell application "Terminal"
        do script (tmuxPath & " new-session -A -s main")
        activate
    end tell
end run
APPLESCRIPT
        ;;
    2)
        # Find Kitty's executable.
        kitty_bin=$(command -v kitty || true)

        if [ -z "$kitty_bin" ] && [ -x "/Applications/kitty.app/Contents/MacOS/kitty" ]; then
            kitty_bin="/Applications/kitty.app/Contents/MacOS/kitty"
        fi

        if [ -z "$kitty_bin" ] && [ -x "$HOME/Applications/kitty.app/Contents/MacOS/kitty" ]; then
            kitty_bin="$HOME/Applications/kitty.app/Contents/MacOS/kitty"
        fi

        if [ -z "$kitty_bin" ]; then
            printf 'Error: Kitty executable not found\n' >&2
            exit 1
        fi

        exec "$kitty_bin" --directory "$HOME" "$tmux_bin" new-session -A -s main
        ;;
esac

