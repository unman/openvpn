# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/rw/config/rc.local:
  file.managed:
    - source: 
      - salt://openvpn/rc.local
    - mode: '0755'
    - replace: True

/rw/config/qubes-firewall-user-script:
  file.managed:
    - source:
      - salt://openvpn/firewall.sh
    - mode: '0755'
    -  replace: True
