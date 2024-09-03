source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/conda-zsh-completion/conda-zsh-completion.plugin.zsh"

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/zoxide-functions.zsh"
source "$ZDOTDIR/git-functions.zsh"
source "$ZDOTDIR/zellij-functions.zsh"
source "$ZDOTDIR/prompt.zsh"


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

# autin
eval "$(atuin init zsh)"
# zoxide

eval "$(zoxide init zsh)"


source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
