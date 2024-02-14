include:
  - openvpn.clone

{% set default_netvm = salt['cmd.shell']('qubes-prefs default_netvm') -%}

'qvm-sync-appmenus template-openvpn':
  cmd.run:
    - runas: user

finalise_menu:
  qvm.shutdown:
    - name: template-openvpn

qvm-present-id:
  qvm.present:
    - name: sys-vpn
    - template: template-openvpn
    - label: green

qvm-prefs-id:
  qvm.prefs:
    - name: sys-vpn
    - netvm: {{ default_netvm }}
    - memory: 300
    - maxmem: 1000
    - vcpus: 2
    - provides-network: True

qvm-features-id:
  qvm.features:
    - name: sys-vpn
    - ipv6: ''
    - disable:
      - service.cups
      - service.cups-browsed
      - service.tinyproxy

vpn_client_menu:
  qvm.features:
    - name: sys-vpn
    - set:
      - menu-items: "vpn_setup.desktop debian-xterm.desktop"
      - default-menu-items: "vpn_setup.desktop debian-xterm.desktop"
