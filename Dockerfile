FROM golang:1.18-alpine AS builder
ARG TS_VERSION
WORKDIR /tmp
RUN apk add git
RUN git clone https://github.com/bogosj/301
RUN cd 301 && CGO_ENABLED=0 GOOS=linux go build -v -a -installsuffix cgo -o 301 *.go
RUN cd /tmp && wget https://pkgs.tailscale.com/stable/tailscale_${TS_VERSION}_amd64.tgz && tar xzvf tailscale_${TS_VERSION}_amd64.tgz

FROM busybox:latest
ARG TS_VERSION
COPY --from=builder /tmp/301/301 /
RUN mkdir /tailscale
COPY --from=builder /tmp/tailscale_${TS_VERSION}_amd64/tailscale* /tailscale/
COPY ./tailscale-up.sh /tailscale/
COPY ./entrypoint.sh /
RUN chmod a+x /entrypoint.sh /tailscale/tailscale-up.sh

ENTRYPOINT [ "/entrypoint.sh" ]
