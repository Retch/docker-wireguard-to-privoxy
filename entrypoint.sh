#!/bin/sh

set -e

CONFFILE=/etc/privoxy/config
PIDFILE=/var/run/privoxy.pid


# wg-quick up /wireguard/wg0.conf

#ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
#wg-quick up /etc/wireguard/$ifname.conf

if [ ! -f "${CONFFILE}" ]; then
	echo "Configuration file ${CONFFILE} not found!"
	exit 1
fi

/usr/sbin/privoxy --no-daemon --pidfile "${PIDFILE}" "${CONFFILE}"

