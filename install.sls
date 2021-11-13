# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
#
installed:
  pkg.installed:
    - pkgs:
      - qubes-core-agent-networking
      - iproute
      - openvpn

systemd-disable:
  cmd.run:
    - name: systemctl disable openvpn
    - name: systemctl disable NetworkManager

systemd-mask:
  cmd.run:
    - name: systemctl mask openvpn
    - name: systemctl mask NetworkManager

/rw/config/vpn:
  file.directory:
    - mkdirs: True
    - force: True

/rw/config/vpn/qubes-vpn-handler.sh:
  file.managed:
    - source:
      - salt://openvpn/qubes-vpn-handler.sh

/rw/config/vpn/install.sh
  file.managed:
    - source:
      - salt://openvpn/install.sh
    - mode: '0755'
    - replace: True
