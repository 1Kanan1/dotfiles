if status is-interactive
    # Commands to run in interactive sessions can go here
end

# source the alias.fish file
if test -f ~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end

alias dotfile="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" 

# Themes for fish
oh-my-posh init fish --config ~/.config/fish/themes/honukai.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/bubblesextra.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/cloud-context.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/emodipt-extend.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/the-unnamed.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/night-owl.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/amro.omp.json | source
#oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/json.omp.json | source

# set the global 'nvim'
set -gx EDITOR nvim
# ghcup-env
#if test -f "/Users/Kanan2003/.ghcup/env"
#    source "/Users/Kanan2003/.ghcup/env"
#end

# NVM setup

# fzf setup for fuzzy completion
eval (fzf --fish)

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
if test -s "/Users/Kanan2003/.bun/_bun"
    source "/Users/Kanan2003/.bun/_bun"
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

# custom 'trash'
function trash
  for item in $argv
    mv $item ~/.Trash/$item
  end
end
