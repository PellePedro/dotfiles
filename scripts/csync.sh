#!/bin/bash

# Set the paths for your mono repo and shadow repo
CONF_REPO_PATH="$HOME/git/letsramp/config/"
SKYRAMP_REPO_PATH="$HOME/git/letsramp/config/"

# Function to print usage
usage() {
  echo "Usage: $0 {local|remote} {hostname|local} {pull|push}"
  echo "  local   - Perform operations on local mono repo"
  echo "  remote  - Perform operations on remote mono repo over SSH"
  echo "  hostname|local - Specify the remote hostname or 'local' if performing locally"
  echo "  pull    - Sync from mono repo to shadow directory"
  echo "  push    - Sync from shadow directory to mono repo"
  exit 1
}

# Check if exactly three arguments are provided
if [ "$#" -ne 3 ]; then
  usage
fi

OPERATION="$1"
HOST="$2"
DIRECTION="$3"

# Perform the requested operation
case "$OPERATION" in
  local)
    SKYRAMP_REPO_PATH="$HOST"
    case "$DIRECTION" in
      pull)
        echo "Pulling VSCode configurations from local mono repo to shadow directory..."
        rsync -avm --include='*/' --include='.vscode/***' --exclude='*' "$SKYRAMP_REPO_PATH/" "$CONF_REPO_PATH/"
        echo "Pull complete."
        ;;
      push)
        echo "Pushing VSCode configurations from shadow directory to local mono repo..."
        rsync -avm --include='*/' --include='.vscode/***' --exclude='*' "$CONF_REPO_PATH/" "$SKYRAMP_REPO_PATH/"
        echo "Push complete."
        ;;
      *)
        usage
        ;;
    esac
    ;;
  remote)
    REMOTE_PATH="$HOST:$SKYRAMP_REPO_PATH"
    case "$DIRECTION" in
      pull)
        echo "Pulling VSCode configurations from remote mono repo to shadow directory..."
        rsync -avm --include='*/' --include='.vscode/***' --exclude='*' -e ssh "$REMOTE_PATH/" "$CONF_REPO_PATH/"
        echo "Pull complete."
        ;;
      push)
        echo "Pushing VSCode configurations from shadow directory to remote mono repo..."
        rsync -avm --include='*/' --include='.vscode/***' --exclude='*' -e ssh "$CONF_REPO_PATH/" "$REMOTE_PATH/"
        echo "Push complete."
        ;;
      *)
        usage
        ;;
    esac
    ;;
  *)
    usage
    ;;
esac
