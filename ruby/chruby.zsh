
if [[ -f "/usr/local/share/chruby/chruby.sh" ]]
then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh

  if [[ -f "$HOME/.ruby-version" ]]; then
    ruby_version=$(head -n 1 "$HOME/.ruby-version")
  else
    ruby_version="2.2.2"
  fi

  chruby "$ruby_version"

  unset ruby_version
fi

