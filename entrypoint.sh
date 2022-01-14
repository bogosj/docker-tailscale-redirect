#!/bin/sh

/tailscale/tailscale-up.sh
/301 -p 80 -d $REDIRECT_DOMAIN
