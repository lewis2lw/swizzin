#!/bin/bash
MASTER=$(cat /root/.master.info | cut -d: -f1)
if [[ ! -f /etc/nginx/apps/nzbhydra.conf ]]; then
  cat > /etc/nginx/apps/nzbhydra.conf <<RAD
location /nzbhydra {
  include /etc/nginx/conf.d/proxy.conf;
  proxy_pass        http://127.0.0.1:5075/nzbhydra;
  auth_basic "What's the password?";
  auth_basic_user_file /etc/htpasswd.d/htpasswd.${MASTER};
}
RAD
fi
sed -i "s/urlBase.*/urlBase\": \"\/nzbhydra\",/g"  /home/"${MASTER}"/.nzbhydra/settings.cfg
sed -i "s/host.*/host\": \"127.0.0.1\",/g"  /home/"${MASTER}"/.nzbhydra/settings.cfg