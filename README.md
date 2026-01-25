# Dotfiles

My personal dotfiles for zsh, tmux, and Ghostty terminal.

## What's Included

- **Zsh** configuration with Oh My Zsh
- **Powerlevel10k** theme
- **Tmux** configuration with TPM plugins
- **Ghostty** terminal configuration

### Zsh Plugins (via git submodules)

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)

### Tmux Plugins (via TPM)

- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- [tmux-themepack](https://github.com/jimeh/tmux-themepack)
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)

## Prerequisites

- Git
- Zsh
- curl (for Oh My Zsh installation)
- A [Nerd Font](https://www.nerdfonts.com/) installed (JetBrainsMono Nerd Font recommended)

## Quick Install

```bash
git clone --recursive git@github.com:ShivaBhattacharjee/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

## Manual Installation

### 1. Clone the repository

```bash
git clone --recursive git@github.com:ShivaBhattacharjee/dotfiles.git ~/.dotfiles
```

If you already cloned without `--recursive`, initialize submodules:

```bash
cd ~/.dotfiles
git submodule update --init --recursive
```

### 2. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Create symlinks

```bash
# Zsh plugins
ln -sf ~/.dotfiles/zsh/plugins/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/
ln -sf ~/.dotfiles/zsh/plugins/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/

# Powerlevel10k theme
ln -sf ~/.dotfiles/zsh/themes/powerlevel10k ~/.oh-my-zsh/custom/themes/

# Config files
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/p10k.zsh ~/.p10k.zsh
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Ghostty (macOS)
ln -sf ~/.dotfiles/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config

# Ghostty (Linux)
# ln -sf ~/.dotfiles/ghostty/config ~/.config/ghostty/config
```

### 4. Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 5. Install Tmux plugins

Open tmux and press `prefix + I` (that's `Ctrl-a + I`) to install plugins.

## Key Bindings

### Tmux

| Key | Action |
|-----|--------|
| `Ctrl-a` | Prefix (instead of Ctrl-b) |
| `prefix + \` | Split window horizontally |
| `prefix + -` | Split window vertically |
| `prefix + r` | Reload tmux config |
| `prefix + h/j/k/l` | Resize panes |
| `prefix + m` | Toggle pane zoom |
| `Ctrl + h/j/k/l` | Navigate between panes (vim-style) |

## Customization

### Powerlevel10k

Run `p10k configure` to customize the prompt.

### Ghostty

Edit `~/.dotfiles/ghostty/config` to customize:
- Font settings
- Color scheme
- Window appearance
- Background opacity and blur

## Updating

### Update dotfiles

```bash
cd ~/.dotfiles
git pull
git submodule update --recursive
```

### Update Oh My Zsh

```bash
omz update
```

### Update Tmux plugins

Press `prefix + U` in tmux.

## Uninstall

```bash
# Remove symlinks
rm ~/.zshrc ~/.p10k.zsh ~/.tmux.conf

# Remove Ghostty config symlink (macOS)
rm ~/Library/Application\ Support/com.mitchellh.ghostty/config

# Remove the dotfiles directory
rm -rf ~/.dotfiles

# Optionally remove Oh My Zsh
rm -rf ~/.oh-my-zsh

# Optionally remove TPM
rm -rf ~/.tmux/plugins
```

## License

MIT
