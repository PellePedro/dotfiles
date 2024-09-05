#!/bin/bash

function install_ubuntu_package() {
    sudo apt-get update -yq
    sudo apt-get install -y --no-install-recommends \
    pkg-config      \
    uidmap          \
    ca-certificates \
    curl            \
    fzf             \
    git             \
    nnn             \
    ripgrep         \
    vim             \
    zsh             \
    build-essential \
    dnsutils        \
    net-tools       \
    netcat          \
    iputils-ping    \
    socat           \
    jq
}

function install_arch_packages() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm \
    pkgconf         \
    shadow          \
    ca-certificates \
    curl            \
    fzf             \
    git             \
    nnn             \
    ripgrep         \
    vim             \
    zsh             \
    base-devel      \
    inetutils       \
    net-tools       \
    gnu-netcat      \
    iputils         \
    socat           \
    jq
}

source /etc/os-release

if [[ "$ID" == "ubuntu" ]]; then
    install_ubuntu_package
elif [[ "$ID" == "arch" ]]; then
    install_arch_packages
else
    echo "The operating system is not recognized as Ubuntu or Arch Linux."
fi
