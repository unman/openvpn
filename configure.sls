# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

vpn_menu:
  qvm.features:
    - name: template-openvpn
    - set:
      - menu-items: "vpn_setup.desktop debian-xterm.desktop"
      - default-menu-items: "vpn_setup.desktop debian-xterm.desktop"
