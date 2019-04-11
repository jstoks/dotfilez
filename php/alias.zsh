configs[php56]=/usr/local/etc/php/5.6
configs[php70]=/usr/local/etc/php/7.0
configs[php71]=/usr/local/etc/php/7.1
configs[php72]=/usr/local/etc/php/7.2
configs[php73]=/usr/local/etc/php/7.3

function config_php {
  phpver="php${1//\.}"
  pushd $configs[$phpver]
  $EDITOR
  popd
}
