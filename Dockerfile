FROM golang:1.17 AS builder
WORKDIR /tmp
RUN git clone https://github.com/bogosj/301
RUN cd 301 && CGO_ENABLED=0 GOOS=linux go build -v -a -installsuffix cgo -o 301 *.go
RUN cd /tmp && wget https://pkgs.tailscale.com/stable/tailscale_1.20.1_amd64.tgz && tar xzvf tailscale_1.20.1_amd64.tgz

FROM busybox:latest
COPY --from=builder /tmp/301/301 /
RUN mkdir /tailscale
COPY --from=builder /tmp/tailscale_1.20.1_amd64/tailscale* /tailscale
COPY ./tailscale-up.sh /tailscale/
COPY ./entrypoint.sh /
RUN chmod a+x /entrypoint.sh /tailscale/tailscale-up.sh

ENTRYPOINT [ "/entrypoint.sh" ]
