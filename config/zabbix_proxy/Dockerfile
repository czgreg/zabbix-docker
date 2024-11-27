FROM zabbix/zabbix-proxy-sqlite3:alpine-6.4.2

USER root

RUN sed -i "6i echo \${ZBX_PSK} > /etc/zabbix/proxy.psk" "/usr/bin/docker-entrypoint.sh"
