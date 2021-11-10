include:
  - openvpn.clone

qvm-present-id:
  qvm.present:
    - name: sys-openvpn
    - template: template-openvpn
    - label: green

qvm-prefs-id:
  qvm.prefs:
    - name: sys-openvpn
    - netvm: sys-firewall
    - memory: 400
    - maxmem: 4000
    - vcpus: 2
    - provides-network: true

qvm-features-id:
  qvm.features:
    - name: sys-openvpn
    - ipv6: ''
    - disable:
      - service.cups
      - service.cups-browsed
      - service.tinyproxy
