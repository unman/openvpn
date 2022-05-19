This is a salt package to set up VPN gateway.  
It follows the method detailed in the [Qubes docs](https://github.com/Qubes-Community/Contents/blob/master/docs/configuration/vpn.md) using iptables and CLI scripts.  
The package creates a qube called sys-vpn based on the debian-11-minimal template.

If the debian-11-minimal template is not present, it will be downloaded and installed - this may take some time depending on your net connection.

There are minor changes to the firewall rules on sys-vpn to ensure blocking of outbound connections.

After installing the package, copy your openvpn configuration file to /rw/config/vpn.  
Run the install.sh script to set up the VPN.  
Restart sys-vpn.  

To use the VPN, set sys-vpn as the netvm for your qubes(s).  
All traffic will go through the VPN.  
The VPN will fail closed if the connection drops.  
No traffic will go through clear.

If you remove the package, (dnf remove 3isec-qubes-sys-vpn), then the salt files will be removed.  
**The sys-vpn gateway will also be removed.**  
To do this **all** qubes will be checked to see if they use sys-vpn.
If they do, their netvm will be set to `none`.
You will manually have to change the netvm if you want them to be online.
