zle -N newtab

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^[edit-command-line' edit-command-line

bindkey ' ' magic-space

if [[ "$(uname -s)" == "Linux" && -f "$HOME/.xmodmap" ]]; then
  source "$HOME/.xmodmap"
fi
