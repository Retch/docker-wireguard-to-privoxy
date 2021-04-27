# docker-wireguard-to-privoxy

docker network create proxynet

docker run -d --cap-add=NET_ADMIN -v /lib/modules:/lib/modules --sysctl="net.ipv4.conf.all.src_valid_mark=1" --privileged -v /path/to/wg/conf:/etc/wireguard --name="proxy" --network="proxynet" retch/docker-wireguard-to-privoxy
