# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm.template-debian-10
# ======================
#
# Installs 'debian-10' template.
#
# Execute:
#   qubesctl state.sls qvm.template-debian-10 dom0
##

template-debian-10:
  pkg.installed:
    - name:     qubes-template-debian-10
    - fromrepo: qubes-templates-itl
