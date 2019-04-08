configs[nginx]=/usr/local/etc/nginx

function config_nginx {
    pushd $configs[nginx]
    $EDITOR
    popd
}
