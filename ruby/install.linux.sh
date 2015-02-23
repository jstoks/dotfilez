
if [[ ! -n "$(type chruby | grep "function")" ]]; then
  echo "Installing chruby"
  wget chruby.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
  tar -xzvf chruby.tar.gz
  cd chruby/
  sudo make install
  cd ..
  rm -rf chruby
  rm chruby.tar.gz
fi

if test ! "$(which ruby-install)"; then
  echo "Installing ruby-install"
  wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
  tar -xzvf ruby-install-0.5.0.tar.gz
  cd ruby-install-0.5.0/
  sudo make install
  cd ..
  rm -rf ruby-install-0.5.0
  rm ruby-install-0.5.0.tar.gz
fi

