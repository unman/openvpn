openvpn_precursor:
  - qvm.template_installed:
    - name: template-debian-11-minimal

qvm-clone-id:
  qvm.clone:
    - name: template-openvpn
    - source: debian-11-minimal
