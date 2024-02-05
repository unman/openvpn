#!/bin/bash
export PATH="$PATH:/usr/sbin:/sbin"
nft list chain qubes output > /rw/config/vpn/output
sed -i '1 i #!/usr/sbin/nft -f ' output
sed -i '1 a flush chain qubes output ' output

case "$1" in

up)
sed -i /53/d output
nft -f output
nft flush chain qubes dnat-dns
# To override DHCP DNS, assign DNS addresses to 'vpn_dns' env variable before calling this script;
# Format is 'X.X.X.X  Y.Y.Y.Y [...]'
if [[ -z "$vpn_dns" ]] ; then
    echo "Getting DNS entry from DHCP " >> /rw/config/vpn/log
    # Parses DHCP foreign_option_* vars to automatically set DNS address translation:
    for optionname in ${!foreign_option_*} ; do
        option="${!optionname}"
        unset fops; fops=($option)
        if [ ${fops[1]} == "DNS" ] ; then vpn_dns="$vpn_dns ${fops[2]}" ; fi
    done
fi

if [[ -n "$vpn_dns" ]] ; then
    # Set DNS address translation in firewall:
    for addr in $vpn_dns; do
	    nft insert rule qubes dnat-dns iifname vif* tcp dport 53 dnat to $addr
	    nft insert rule qubes dnat-dns iifname vif* udp dport 53 dnat to $addr
    done
    su - -c 'notify-send "$(hostname): LINK IS UP." --icon=network-idle' user
else
    su - -c 'notify-send "$(hostname): LINK UP, NO DNS!" --icon=dialog-error' user
fi

;;
down)
su - -c 'notify-send "$(hostname): LINK IS DOWN !" --icon=dialog-error' user
unset foreign_option_*
nft -f output.bak
nft flush chain qubes dnat-dns

# Restart the VPN automatically
sleep 5s
sudo /rw/config/rc.local
;;
esac
