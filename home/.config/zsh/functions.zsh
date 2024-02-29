function n()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    EDITOR=lvim nnn -e

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

function s() {
  CMD=$(cat ~/bin/skyramp_command | fzf)
  echo "# $CMD"
  eval $CMD
}

function l() {
  CMD=$(ls | fzf)
  echo "# $CMD"
  eval "./$CMD"
}

function j() {
  just -l | fzf --prompt="just  " --height=50% --layout=reverse | xargs -I {} just {}
}

#  docker images |grep worker | awk '{print $1 ":"$2 }' | fzf --reverse
function kl() {
  IMAGE=$(docker images | grep worker | awk '{print $1 ":" $2}' | fzf --reverse)
  kind load docker-image $IMAGE --name hostpath
}

function dk() {
  IMAGE=$(docker images | awk '{print $1 ":" $2}' | fzf --reverse)
  docker rmi -f $IMAGE
}

alias avim="NVIM_APPNAME=AstroNvim nvim"

function vims() {
  items=("govim" "AstroNvim" "1Nvim", "BasicIDE" "LazyVim" )
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
