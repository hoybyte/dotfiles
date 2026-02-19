#!/usr/bin/env bash
set -euo pipefail

REPO_SSH="git@github.com:hoybyte/dotfiles.git"
REPO_HTTPS="https://github.com/hoybyte/dotfiles.git"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/workspace/dotfiles}"
NVIM_SRC="$DOTFILES_DIR/nvim"
NVIM_DST="$HOME/.config/nvim"

timestamp() { date +"%Y%m%d-%H%M%S"; }

is_wsl() {
    grep -qiE "microsoft|wsl" /proc/version 2>/dev/null
}

have_cmd() { command -v "$1" >/dev/null 2>&1; }

install_git_best_effort() {
    if have_cmd git; then return 0; fi

    echo "git not found. Attempting to install (best effort)..."
    if have_cmd apt-get; then
        sudo apt-get update -y
        sudo apt-get install -y git
    elif have_cmd pacman; then
        sudo pacman -Sy --noconfirm git
    else
        echo "Could not auto-install git (no apt-get or pacman). Please install git manually."
        exit 1
    fi
}

clone_or_update_repo() {
    mkdir -p "$(dirname "$DOTFILES_DIR")"

    if [ -d "$DOTFILES_DIR/.git" ]; then
        echo "Updating existing dotfiles repo at: $DOTFILES_DIR"
        git -C "$DOTFILES_DIR" pull --rebase
        return 0
    fi

    echo "Cloning dotfiles repo into: $DOTFILES_DIR"
    # Prefer SSH if you have keys set up; fall back to HTTPS
    if git clone "$REPO_SSH" "$DOTFILES_DIR" 2>/dev/null; then
        return 0
    fi

    echo "SSH clone failed (maybe no SSH key). Falling back to HTTPS..."
    git clone "$REPO_HTTPS" "$DOTFILES_DIR"
}

backup_path_if_exists() {
    local p="$1"
    if [ -L "$p" ]; then
        echo "Existing symlink found at $p (will replace)."
        rm -f "$p"
    elif [ -e "$p" ]; then
        local b="${p}.bak-$(timestamp)"
        echo "Backing up existing $p -> $b"
        mv "$p" "$b"
    fi
}

link_nvim() {
    if [ ! -d "$NVIM_SRC" ]; then
        echo "ERROR: Expected Neovim config folder not found: $NVIM_SRC"
        echo "Repo layout assumption: $DOTFILES_DIR/nvim"
        exit 1
    fi

    mkdir -p "$HOME/.config"
    backup_path_if_exists "$NVIM_DST"

    echo "Linking $NVIM_DST -> $NVIM_SRC"
    ln -s "$NVIM_SRC" "$NVIM_DST"
}

main() {
    echo "== Dotfiles bootstrap =="
    echo "Target repo dir : $DOTFILES_DIR"
    echo "Neovim src      : $NVIM_SRC"
    echo "Neovim dest     : $NVIM_DST"

    if is_wsl; then
        echo "Environment     : WSL detected"
    else
        echo "Environment     : Linux detected"
    fi

    install_git_best_effort
    clone_or_update_repo
    link_nvim

    echo "Done."
    echo "Verify:"
    echo "  ls -l ~/.config | grep nvim"
}

main "$@"
