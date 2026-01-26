set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -gx EDITOR "nvim"
set -gx LESS --mouse
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EZA_CONFIG_DIR $HOME/.config/eza
set -gx MANPAGER "nvim +Man!"
set -gx BAT_THEME TwoDark
set -gx PYTHONPYCACHEPREFIX /tmp/__pycache__/

# PostgreSQL@16 flags
set -gx LDFLAGS "-L/opt/homebrew/opt/postgresql@16/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/postgresql@16/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/postgresql@16/lib/pkgconfig"

# Bun setup
set -gx BUN_INSTALL "$HOME/.bun"
