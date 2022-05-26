#!/bin/sh
# Author: Jakub 'unknow' Mrugalski - https://mrugalski.pl
# Do NOT run this script manually - it shoule be auto-executed inside docker!

out=/etc/nginx/conf.d/default.conf

if [ ! -f /config ]; then
    echo "No config file found... nothing to do";
    exit 1;
fi

# remove content of original nginx config file
echo -n >$out

for cfg in $(cat /config); do
    domain=$(echo $cfg | cut -f1 -d=)
    destination=$(echo $cfg | cut -f2 -d=)
    echo ">> Building config for $domain";

    config=$(cat <<EOF
server {
    listen       80;
    listen  [::]:80;
    server_name  $domain;

    location / {
        proxy_pass $destination;
        proxy_set_header Host \$host;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_ssl_name \$host;
        proxy_ssl_server_name on;
        proxy_ssl_verify off;
        proxy_ssl_protocols  TLSv1 TLSv1.1 TLSv1.2;
        proxy_ssl_session_reuse off;
        proxy_set_header X-Forwarded-For \$remote_addr;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_read_timeout 120;
        proxy_send_timeout 120;
        proxy_connect_timeout 120;
    }
}
EOF
)
    
    # append new config to the end of nginx config file
    echo "$config" >>$out
done
