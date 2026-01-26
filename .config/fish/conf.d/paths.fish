# Add paths
fish_add_path /opt/homebrew/opt/postgresql@16/bin
fish_add_path $HOME/.bun/bin
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.pyenv/shims
fish_add_path $HOME/.pyenv/bin
fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path $HOME/.cargo/bin

# Homebrew fish completions
if type -q brew
    set -l brew_prefix (brew --prefix)
    if test -d "$brew_prefix/share/fish/completions"
        set -p fish_complete_path "$brew_prefix/share/fish/completions"
    end

    if test -d "$brew_prefix/share/fish/vendor_completions.d"
        set -p fish_complete_path "$brew_prefix/share/fish/vendor_completions.d"
    end
end
