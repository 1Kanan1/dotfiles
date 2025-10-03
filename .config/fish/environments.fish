set -x STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -x EDITOR "nvim" # for superfile (spf)
set -x LESS --mouse # for scrolling with mouse (e.g., git log, man)
set -x XDG_CONFIG_HOME $HOME/.config
set -x EZA_CONFIG_DIR $HOME/.config/eza # set eza config
set -x MANPAGER "nvim +Man!" # using nvim to read manpage

# import Homebrew fish completions
if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end
