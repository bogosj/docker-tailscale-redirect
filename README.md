# tailscale-redirect

## About

A quick and easy way to make typing "m/" in your web browser bring you to Gmail, or wherever else your heart desires.

## Usage

Add as many short domains to your Tailnet as you wish. Generate a reusable key in your [Tailscale admin settings](https://login.tailscale.com/admin/settings/keys) and provide it to as many containers as you want. Each will get its own Tailnet IP address and get added into your Tailscale MagicDNS using the hostname provided as an environment variable.

```sh
#!/bin/sh

TS_KEY=tskey-kT4ZMV6CNTRL-oyBH3EvafZjaLKVazym2He

docker run --name=tailscale-c -d \
        --restart=unless-stopped \
        -e TS_AUTHKEY=$TS_KEY \
        -e TS_HOSTNAME=c \
        -e REDIRECT_DOMAIN=calendar.google.com \
        ghcr.io/bogosj/tailscale-redirect

docker run --name=tailscale-m -d \
        --restart=unless-stopped \
        -e TS_AUTHKEY=$TS_KEY \
        -e TS_HOSTNAME=m \
        -e REDIRECT_DOMAIN=mail.google.com \
        ghcr.io/bogosj/tailscale-redirect
```
