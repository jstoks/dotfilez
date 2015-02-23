
if [[ ! -n "$(type chruby | grep "function")" ]]; then
  echo "Installing chruby"
  brew install chruby
fi

if test ! "$(which ruby-install)"; then
  echo "Installing ruby-install"
  brew install ruby-install
fi

