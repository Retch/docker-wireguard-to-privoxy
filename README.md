# docker-wireguard-to-privoxy

docker run -d -p 8118:8118 --cap-add=NET_ADMIN -v /path/to/wg/conf:/etc/wireguard -v /lib/modules:/lib/modules --sysctl="net.ipv4.conf.all.src_valid_mark=1" --privileged retch/docker-wireguard-to-privoxy:latest
