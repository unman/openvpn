# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
#

{% if salt['pillar.get']('update_proxy:caching') %}


/etc/apt/sources.list:
  file.replace:
    - names:
      - /etc/apt/sources.list
      - /etc/apt/sources.list.d/qubes-r4.list
    - pattern: 'https://'
    - repl: 'http://HTTPS///'
    - flags: [ 'IGNORECASE', 'MULTILINE' ]

{% endif %}

vpn_update:
  pkg.uptodate:
    - refresh: True

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
    - replace: True

/rw/config/vpn:
  file.directory:
    - mkdirs: True
    - force: True

/rw/config/vpn/qubes-vpn-handler.sh:
  file.managed:
    - source:
      - salt://openvpn/qubes-vpn-handler.sh
    - user: root
    - mode: '0755'

/etc/skel/install.sh:
  file.managed:
    - source:
      - salt://openvpn/install.sh
    - user: root
    - mode: '0755'
    - replace: True

/home/user/install.sh:
  file.managed:
    - source:
      - salt://openvpn/install.sh
    - user: root
    - mode: '0755'
    - replace: True

helper_script_menu:
  file.managed:
    - name: /usr/share/applications/vpn_setup.desktop
    - source: salt://openvpn/vpn_setup.desktop
    - user: user
    - group: user
    - mode: 755

