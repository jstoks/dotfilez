configs[apache]=/usr/local/etc/httpd

function config_apache {
    pushd $configs[apache]
    $EDITOR
    popd
}
