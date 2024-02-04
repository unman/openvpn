#!/bin/bash

#    Add the `qvpn` group to system, if it doesn't already exist
if ! grep -q "^qvpn:" /etc/group ; then
     groupadd -rf qvpn
     sync
fi
sleep 2s

/rw/config/firewall.nft
