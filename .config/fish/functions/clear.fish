function clear
    # Clear the screen and the scrollback buffer
    printf '\033[2J\033[3J\033[H'
    # Clear tmux history if we are inside a tmux session
    if set -q TMUX
        command tmux clear-history
    end
end
