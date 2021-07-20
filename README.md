# docker-wireguard-to-privoxy

## First create a bridge network
docker network create proxynet

## Start the container and attach it to the created bridge
docker run -d --cap-add=NET_ADMIN -v /lib/modules:/lib/modules --sysctl="net.ipv4.conf.all.src_valid_mark=1" --privileged -v /path/to/wg/conf:/etc/wireguard --name="proxy1" --network="proxynet" ghcr.io/retch/docker-wireguard-to-privoxy:main

## Attach other containers to the bridge and add the container name
docker run....  --network="proxynet" --env http_proxy="proxy1:8118" --env https_proxy="proxy1:8118"
