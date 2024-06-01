#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR=nvim
export PATH=$HOME/bin:$USER/.local/bin:/usr/local/bin:$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export GOPATH=$HOME/go
export PKG_CONFIG_PATH=/usr/local/opt/sqlite/lib/pkgconfig
export CLICOLOR=1

# export LSCOLORS=gxFxCxDxBxegedabagaced


# NNN Configuration
# NNN Bookmarks
NNN_BMS="b:~/.config/nnn/bookmarks"
NNN_BMS="c:~/.config;$NNN_BMS"
NNN_BMS="n:~/.config/nvim;$NNN_BMS"
NNN_BMS="z:~/.config/zsh;$NNN_BMS"
NNN_BMS="g:~/git;$NNN_BMS"
NNN_BMS="h:~;$NNN_BMS"
export NNN_BMS


# NNN Plugins
NNN_PLUG="e:-!sudo -E nvim $nnn*;"
NNN_PLUG="n:-!nvim;"
NNN_PLUG="g:!lazygit;$NNN_PLUG"
NNN_PLUG="j:autojump;$NNN_PLUG"
NNN_PLUG="r:renamer;$NNN_PLUG"
export NNN_PLUG

BLK="42"
CHR="42"
DIR="42"
EXE="F7"
REG="F7"
HARDLINK="42"
SYMLINK="48"
MISSING="42"
ORPHAN="42"
FIFO="42"
SOCK="42"
OTHER="42"

export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_COLORS='2635'

export NNN_USE_EDITOR=1
export NNN_OPENER=nvim
