
# fzf config
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

if [ "$PLATFORM" = "Darwin" ]; then
  export PATH="$(brew_prefix coreutils)/libexec/gnubin:$PATH"
  export MANPATH="$(brew_prefix coreutils)/libexec/gnuman:$MANPATH"
fi

export PATH="./bin:$HOME/.bin:$HOME/bin:$PATH"
