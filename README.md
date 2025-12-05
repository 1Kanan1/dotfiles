# 🏠 Dotfiles

My personal dotfiles for **macOS** and **Linux**, managed with [GNU Stow](https://www.gnu.org/software/stow/).  
This repo sets up my shell, editors, terminal, and a bunch of handy CLI tools.

---

## 📂 Directory Layout

```

 dotfiles
├──  .config # app configs
│   ├──  atuin
│   ├──  fish
│   ├──  ghostty
│   ├──  lazydocker
│   ├──  lazygit
│   ├──  nvim
│   ├──  starship
│   └──  yazi
├── 󰊢 .gitconfig
├──  .stow-local-ignore
├── 󱁻 .tmux.conf
└── 󰂺 README.md

```

---

## 🚀 Setup

Clone this repo into your home directory:

```sh
git clone https://github.com/1Kanan1/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 🍺 Install Homebrew (macOS or Linux)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 📦 Install Packages

```sh
brew install \
  font-hack-nerd-font       # patched font with embedded icons from popular icon sets (for Linux, add `--cask` after `install`)

brew install \
  delta                     # git diff viewer with syntax highlighting
  lazydocker                # TUI for docker
  lazygit                   # TUI for git
  eza                       # modern ls replacement
  tmux                      # terminal multiplexer
  fish                      # user-friendly shell
  neovim                    # text editor
  stow                      # manage dotfiles with symlinks
  starship                  # fancy shell prompt
  atuin                     # shell history manager
  bat                       # cat with wings (syntax highlighting)
  fzf                       # fuzzy finder
  ghostty                   # GPU-accelerated terminal emulator
  ripgrep                   # fast grep alternative
  imagemagick               # image manipulation tools
  jq                        # JSON processor
  fd                        # modern find replacement
  xh                        # friendly HTTP client
  gh                        # GitHub CLI
  glab                      # GitLab CLI
  rm-improved               # safer rm command

# optional extras:
brew install httpie         # alternative HTTP client
brew install posting        # post stuff from the terminal
```

### 🔗 Stow Configs

Symlink configs into `$HOME`:

```sh
stow .
```

### 🐟 Change Default Shell to Fish

```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

---

## 📝 Notes

- `stow-local-ignore` makes sure `.git` and other repo-only files don’t get symlinked.
- Some configs are macOS-first, but most will work fine on Linux.
- Optional tools (`httpie`, `posting`) won’t break anything if skipped.

## TODO

- mention, that tmux uses TPM and installing it requires pulling the git repo (`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`)
