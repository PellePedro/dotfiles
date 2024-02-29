#!/bin/bash

REMOTE=$1
rsync -avz $HOME/.dotfiles/ $REMOTE:~$USER/.dotfiles
