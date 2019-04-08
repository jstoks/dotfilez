configs[nginx]=/usr/local/etc/nginx/nginx.conf

function config_nginx {
    $EDITOR $configs[nginx]
}
