#!/bin/bash
#
set -e

dry_run=false
while getopts 'd' opt; do
    case "$opt" in
        n) dry_run=true ;;
        d) stow -t $HOME -v -D home
           exit 0 ;;
        *) echo 'error in command line parsing' >&2
           exit 1
    esac
done

if "$dry_run"; then
  stow --simulate -t $HOME -vv -D home
  stow --simulate -t $HOME -vv home
else
  # remove any existing symlinks
  stow -t $HOME -v -D home
  # 
  stow -t $HOME -v home
fi
