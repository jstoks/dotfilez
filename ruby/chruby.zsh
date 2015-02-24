
if [[ -f "/usr/local/share/chruby/chruby.sh" ]]
then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

chruby 2.2.0