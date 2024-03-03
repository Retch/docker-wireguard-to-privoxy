# docker-wireguard-to-privoxy
## Prerequisites
Wireguard Kernel module has to be installed
https://www.wireguard.com/install/

## Run as proxy for other containers

### First create a bridge network
```
docker network create proxynet
```

### Start the container and attach it to the created bridge
```
docker run -d --cap-add=NET_ADMIN -v /lib/modules:/lib/modules --sysctl="net.ipv4.conf.all.src_valid_mark=1" --privileged -v /path/to/wg/conf:/etc/wireguard --name="proxy1" --network="proxynet" ghcr.io/retch/docker-wireguard-to-privoxy:main
```

### Attach other containers to the bridge and add the container name
```
docker run....  --network="proxynet" --env http_proxy="proxy1:8118" --env https_proxy="proxy1:8118"
```

## Expose proxy on local interface for other programs with compose
Remove the 127.0.0.1 to expose the proxy on all interfaces (be careful with public interface).
Add more containers with seperate config directories.

```
version: '3'

services:
  proxy1:
    image: ghcr.io/retch/docker-wireguard-to-privoxy:main
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
    volumes:
      - /lib/modules:/lib/modules
      - ./configdir1:/etc/wireguard
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    ports:
      - "127.0.0.1:8001:8118"
    privileged: true
    healthcheck:
      test: wget --no-verbose --tries=1 --spider https://duckduckgo.com || exit 1
      interval: 1m
      timeout: 10s
      retries: 2
      start_period: 10s
```
