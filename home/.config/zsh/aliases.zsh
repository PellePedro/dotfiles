#!/bin/zsh
alias vi='nvim'
alias x='exit'
alias f='zi'
alias g='lazygit'
alias r=$HOME/git/letsramp/skyramp/.vscode/scripts/run-action.sh

alias ze="zellij -l ~/.config/zellij/layout.kdl attach dev --create"
alias zek="zellij kill-all-sessions"
alias zr="zellij run --"
alias nz="nnn ~/.config/zellij"
alias nc="nnn ~/.config/zsh"


# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

*)
	# echo 'Other OS'
	;;
esac
