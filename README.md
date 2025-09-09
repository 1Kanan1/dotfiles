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
│   ├──  lazygit
│   ├──  nvim
│   ├──  starship
│   └──  yazi
├──  .git
├── 󰊢 .gitconfig
├──  .stow-local-ignore
├── 󱁻 .tmux.conf
└── 󰂺 README.md

```

---

## 🚀 Setup

Clone this repo into your home directory:

```sh
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 🍺 Install Homebrew (macOS only)

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 📦 Install Packages

```sh
brew install delta lazygit eza tmux fish neovim stow starship atuin bat fzf ghostty ripgrep imagemagick jq fd xh
# optional:
brew install httpie
brew install posting
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
