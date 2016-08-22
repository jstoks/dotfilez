export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

if hash brew 2>/dev/null ; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
fi
  
export PATH="./bin:$ZSH/bin:$HOME/.bin:$HOME/bin:$PATH"
