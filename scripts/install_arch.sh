#!/bin/bash

sudo pacman -Syu 
sudo pacman -Syu \
    gcc \
    make \
    base-devel \
    git \
    nodejs \
    npm \
    python \
    python-pip \
    python-virtualenv \
    neovim \
    go \
    btop \
    btrfs-progs \
    stow \
    zsh \
    nnn

paru -Syu \
    staticcheck \
    zellij \
    golangci-lint-bin \
    kind \
    kubectl \
    zoxide \
    unzip \
    lazygit \
    lazydocker \
    fzf \
    ripgrep \
    git-delta \
    btop


