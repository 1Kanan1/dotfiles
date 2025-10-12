if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_tmux_fixterm_with_256color "tmux-256color"
    set fish_tmux_autostart true

    set -gx ATUIN_NOBIND "true"
    atuin init fish | source
    fzf --fish | FZF_ALT_C_COMMAND= source
end

starship init fish | source

if test -f ~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end

if test -f ~/.config/fish/environments.fish
    source ~/.config/fish/environments.fish
end

# set the global 'nvim'
set -gx EDITOR nvim

# NVM setup (node --version > $HOME/.nvmrc)
eval nvm use >> /dev/null

# ----- Podman DOCKER_HOST -----

#set DOCKER_HOST "unix://$HOME/.orbstack/run/docker.sock"

# ----- Bat (better cat) -----
set -x BAT_THEME "TwoDark"


# ----- PostgreSQL@16 -----
# If you need to have postgresql@16 first in your PATH
set -x PATH "/opt/homebrew/opt/postgresql@16/bin:$PATH"
# For compilers to find postgresql@16 you may need to set:
set -x LDFLAGS "-L/opt/homebrew/opt/postgresql@16/lib"
set -x CPPFLAGS "-I/opt/homebrew/opt/postgresql@16/include"
# For pkg-config to find postgresql@16 you may need to set:
set -x PKG_CONFIG_PATH "/opt/homebrew/opt/postgresql@16/lib/pkgconfig"

# ----- Bun -----
# bun setup
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH "$BUN_INSTALL/bin:$PATH"

# bun completions
if test -s "$HOME/.bun/_bun"
    source "$HOME/.bun/_bun"
end


set -x PATH "/usr/local/bin:$PATH"

# uv tools
set -x PATH "$HOME/.local/bin:$PATH"

# pyenv setup
set -x PATH "$HOME/.pyenv/shims:$PATH"
set -x PATH "$HOME/.pyenv/bin:$PATH"
set -x PYTHONPYCACHEPREFIX "/tmp/__pycache__/"

# rust & cargo
set -x PATH "/opt/homebrew/opt/rustup/bin:$PATH"
set -x PATH "$HOME/.cargo/bin:$PATH"

bind \cr _atuin_search

# custom 'trash'
function trash
  for item in $argv
    mv $item ~/.Trash/$item
  end
end
