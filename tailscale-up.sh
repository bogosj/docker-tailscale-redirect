#!/bin/sh

mkdir /tailscale/state
/tailscale/tailscaled --statedir=/tailscale/state --tun=userspace-networking &
/tailscale/tailscale up --authkey=$TS_AUTHKEY --hostname=$TS_HOSTNAME &
