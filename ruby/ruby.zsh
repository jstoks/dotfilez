
if [[ -f "/usr/local/share/chruby/chruby.sh" ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh

  chruby_auto
fi

if [[ "$(command -v rbenv)" ]]; then
  eval "$(rbenv init -)"
fi

