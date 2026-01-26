# Main fish config

# Initialization for both interactive and non-interactive sessions
if type -q starship
    starship init fish | source
end

if type -q mise
    mise activate fish | source
end

# Added by OrbStack: command-line tools and integration
if test -f ~/.orbstack/shell/init2.fish
    source ~/.orbstack/shell/init2.fish
end

if status is-interactive
    # Tmux setup
    set -g fish_tmux_fixterm_with_256color tmux-256color
    set -g fish_tmux_autostart true

    # Tool initializations
    if type -q atuin
        atuin init fish | source
    end

    if type -q fzf
        fzf --fish | source
    end

    # Key bindings
    bind \cr _atuin_search

    # Bun completions
    if test -s "$HOME/.bun/_bun"
        source "$HOME/.bun/_bun"
    end
end