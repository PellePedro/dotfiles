#!/bin/bash

brew bundle --file=./Brewfile
./sync.sh
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

