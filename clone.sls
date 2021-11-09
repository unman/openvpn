include:
  - template-debian-10

qvm-clone-id:
  qvm.clone:
    - require:
      - sls: template-debian-10 
    - name: template-openvpn
    - source: debian-10
