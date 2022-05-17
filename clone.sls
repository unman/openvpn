include:
  - template-debian-11

qvm-clone-id:
  qvm.clone:
    - require:
      - sls: template-debian-11 
    - name: template-openvpn
    - source: debian-11
