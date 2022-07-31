# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
#

{% if salt['qvm.exists']('cacher') %}

/etc/apt/sources.list:
  file.replace:
    - names:
      - /etc/apt/sources.list
      - /etc/apt/sources.list.d/qubes-r4.list
    - pattern: 'https://'
    - repl: 'http://HTTPS///'
    - flags: [ 'IGNORECASE', 'MULTILINE' ]

{% endif %}

installed:
  pkg.installed:
    - pkgs:
      - qubes-core-agent-networking
      - qubes-core-agent-passwordless-root
      - iproute2
      - libnotify-bin
      - mate-notification-daemon
      - openvpn
      - unzip
      - zenity

systemd-disable:
  cmd.run:
    - name: systemctl disable openvpn
    - name: systemctl disable openvpn-server@.service
    - name: systemctl disable openvpn-client@.service

systemd-mask:
  cmd.run:
    - name: systemctl mask openvpn
    - name: systemctl mask openvpn-server@.service
    - name: systemctl mask openvpn-client@.service

