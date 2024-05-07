# Created by Zap installer

source "$HOME/.config/zsh/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"


if command -v fzf &> /dev/null; then
    [ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    if [[ "$(uname -s)" == "Darwin" && "$(command -v brew)" != "" ]] ; then
        local FZF_HOME=$(brew --prefix)/opt/fzf
        [ -f $FZF_HOME/shell/completion.zsh ] && source $FZF_HOME/shell/completion.zsh
        [ -f $FZF_HOME/shell/key-bindings.zsh ] && source $FZF_HOME/shell/key-bindings.zsh
    fi
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
OS=$(uname -s)

case "$OS" in
  Linux)
      ;;
  Darwin)
      ;;
  *)
    echo "Unknown OS: $OS"
    ;;
esac

eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
