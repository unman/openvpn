openvpn_precursor:
  qvm.template_installed:
    - name: debian-12-minimal

qvm-clone-id:
  qvm.clone:
    - name: template-openvpn
    - source: debian-12-minimal

vpn_menu:
  qvm.features:
    - name: template-openvpn
    - set:
      - menu-items: "vpn_setup.desktop debian-xterm.desktop"
      - default-menu-items: "vpn_setup.desktop debian-xterm.desktop"

start-template-openvpn:
  qvm.start:
    - name: template-openvpn
