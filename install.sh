#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installing dotfiles from ${DOTFILES_DIR}${NC}"

# Initialize and update submodules
echo -e "${YELLOW}Initializing git submodules...${NC}"
cd "$DOTFILES_DIR"
git submodule update --init --recursive

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo -e "${GREEN}Oh My Zsh already installed${NC}"
fi

# Create oh-my-zsh custom directories if they don't exist
mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"

# Backup existing files
backup_file() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo -e "${YELLOW}Backing up existing $1 to $1.backup${NC}"
        mv "$1" "$1.backup"
    elif [ -L "$1" ]; then
        rm "$1"
    fi
}

# Link zsh plugins
echo -e "${YELLOW}Linking zsh plugins...${NC}"
backup_file "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
ln -sf "$DOTFILES_DIR/zsh/plugins/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

backup_file "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
ln -sf "$DOTFILES_DIR/zsh/plugins/zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

# Link powerlevel10k theme
echo -e "${YELLOW}Linking powerlevel10k theme...${NC}"
backup_file "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
ln -sf "$DOTFILES_DIR/zsh/themes/powerlevel10k" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

# Link zshrc
echo -e "${YELLOW}Linking .zshrc...${NC}"
backup_file "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Link p10k.zsh
echo -e "${YELLOW}Linking .p10k.zsh...${NC}"
backup_file "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/zsh/p10k.zsh" "$HOME/.p10k.zsh"

# Link tmux.conf
echo -e "${YELLOW}Linking .tmux.conf...${NC}"
backup_file "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Install TPM (Tmux Plugin Manager) if not installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo -e "${YELLOW}Installing Tmux Plugin Manager...${NC}"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo -e "${GREEN}Tmux Plugin Manager already installed${NC}"
fi

# Link Ghostty config
echo -e "${YELLOW}Linking Ghostty config...${NC}"
GHOSTTY_CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
if [[ "$OSTYPE" == "darwin"* ]]; then
    mkdir -p "$GHOSTTY_CONFIG_DIR"
    backup_file "$GHOSTTY_CONFIG_DIR/config"
    ln -sf "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_CONFIG_DIR/config"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
    mkdir -p "$GHOSTTY_CONFIG_DIR"
    backup_file "$GHOSTTY_CONFIG_DIR/config"
    ln -sf "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_CONFIG_DIR/config"
fi

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo -e "${YELLOW}Post-installation steps:${NC}"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. For tmux plugins, open tmux and press: prefix + I (Ctrl-a + I)"
echo "3. Install a Nerd Font (e.g., JetBrainsMono Nerd Font) for icons to display correctly"
echo ""
