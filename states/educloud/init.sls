
include:
  - server.python
  - apache
  - postgresql

educloud-python:
  pkg.installed:
    - names:
      - python-ldap

educloud:
  user.present:
    - fullname: educloud
    - password: '*'
    - shell: /bin/bash
    - home: /home/educloud

/home/educloud:
  file.directory:
    - user: educloud
    - mode: 775

# virtualenv
/home/educloud/venv:
  virtualenv.managed:
    - user: educloud
    - system_site_packages: True
    - requirements: salt://educloud/requirements.txt
    - require:
      - pkg: python-virtualenv
      - user: educloud

# supervisor
/etc/supervisor/conf.d/educloud.conf:
  file.managed:
    - source: salt://educloud/supervisor.conf
    - user: educloud
    - group: educloud
    - mode: 0644
    - template: jinja
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor

# PostgreSQL
{{ pillar['educloud']['db']['user'] }}-postgres-user:
  postgres_user.present:
    - name: {{ pillar['educloud']['db']['user'] }}
    - createdb: {{ pillar['educloud']['db']['database'] }}
    - password: {{ pillar['educloud']['db']['password'] }}
    - require:
      - service: postgresql
      - pkg: python-psycopg2

{{ pillar['educloud']['db']['database'] }}-postgres-db:
  postgres_database.present:
    - name: {{ pillar['educloud']['db']['database'] }}
    - owner: {{ pillar['educloud']['db']['user'] }}
    - encoding: UTF8
    - lc_ctype: en_US.UTF-8
    - lc_collate: en_US.UTF-8
    - template: template0
    - require:
      - service: postgresql
      - postgres_user: {{ pillar['educloud']['db']['user'] }}-postgres-user

