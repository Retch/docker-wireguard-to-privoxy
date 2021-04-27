
FROM alpine:3.13

RUN apk --no-cache add privoxy wireguard-tools
ADD entrypoint.sh /usr/local/bin/
ADD config /etc/privoxy/
RUN chmod +r /etc/privoxy/config && chmod +x /usr/local/bin/entrypoint.sh
RUN mv /etc/privoxy/default.filter.new /etc/privoxy/default.filter \
    && mv /etc/privoxy/user.filter.new /etc/privoxy/user.filter \
    && mv /etc/privoxy/match-all.action.new /etc/privoxy/match-all.action \
    && mv /etc/privoxy/default.action.new /etc/privoxy/default.action \
    && mv /etc/privoxy/user.action.new /etc/privoxy/user.action \
    && mv /etc/privoxy/regression-tests.action.new /etc/privoxy/regression-tests.action \
    && mv /etc/privoxy/trust.new /etc/privoxy/trust
    

VOLUME [ "/etc/wireguard" ]

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 8118
