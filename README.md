This is a salt package to set up a qube which functions as a VPN gateway.  
It follows the method detailed in the [Qubes docs](https://github.com/Qubes-Community/Contents/blob/master/docs/configuration/vpn.md) using iptables and CLI scripts.  
The package creates a qube called sys-openvpn based on the debian-11 template.

If the debian-11 template is not installed, then it will be downloaded and installed - this may take some time depending on your net connection.

