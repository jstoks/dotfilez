alias sw="tmux switch -t"
alias nvim="nocorrect nvim"
alias vi="nvim"
alias tmux='TERM=screen-256color tmux -2'
alias tmuxinator='TERM=screen-256color tmuxinator'
alias mux='TERM=screen-256color mux'


if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
else
  alias ls="ls --color"
fi

hash -d proj="$PROJECTS"
hash -d lab="$LAB"
hash -d dev="$DEV"
