bindkey -e
zle -N newtab

bindkey '^[;3D' backward-word
bindkey '^[;3C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

[[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
[[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
[[ -z "$terminfo[kend]" ]] || bindkey -M vicmd "$terminfo[kend]" vi-end-of-line
[[ -z "$terminfo[kich1]" ]] || bindkey -M vicmd "$terminfo[kich1]" overwrite-mode
[[ -z "$terminfo[khome]" ]] || bindkey -M viins "$terminfo[khome]" beginning-of-line
[[ -z "$terminfo[kend]" ]] || bindkey -M viins "$terminfo[kend]" end-of-line

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

if [[ "$(uname -s)" == "Linux" ]]; then
  [[ -f "$HOME/.xmodmap" ]] && source "$HOME/.xmodmap"
  xcape -e "Caps_Lock=Escape"
fi

unsetopt nomatch
