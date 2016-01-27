
{% set swapfile = '/swapfile1' %}

create-swapfile-cmd:
  cmd.run:
    - name: dd if=/dev/zero of={{ swapfile }} bs=1024 count=524288
    - creates: {{ swapfile }}

mkswap-cmd:
  cmd.run:
    - name: mkswap {{ swapfile }}
    - require:
      - cmd: create-swapfile-cmd
    - onchanges:
      - cmd: create-swapfile-cmd

swapfile-perms:
  file.managed:
    - name: {{ swapfile }}
    - user: root
    - group: root
    - mode: 0600
    - require:
      - cmd: create-swapfile-cmd

swapon-cmd:
  cmd.run:
    - name: swapon {{ swapfile }}
    - require:
      - cmd: mkswap-cmd
    - onchanges:
      - cmd: create-swapfile-cmd

swapfile-fstab-file:
  file.append:
    - name: /etc/fstab
    - text: {{ swapfile }} swap swap default 0 0

