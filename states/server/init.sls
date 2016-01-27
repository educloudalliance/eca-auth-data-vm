
# This directory contains states that are used on production servers

include:
  - locale

server-essential-packages:
  pkg.installed:
    - names:
      - bash
      - mercurial
      - git
      - ntp
      - python-software-properties
      - supervisor
      - sysstat
      - update-notifier-common

supervisor:
  service:
    - name: supervisor
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: supervisor

