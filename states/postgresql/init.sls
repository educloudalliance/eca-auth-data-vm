
postgresql:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/postgresql/9.3/main/pg_hba.conf
    - require:
      - pkg: postgresql

/etc/postgresql/9.3/main/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 0644
    - template: jinja
    - require:
      - pkg: postgresql
    - watch_in:
      - service: postgresql

/etc/postgresql/9.3/main/postgresql.conf:
  file.managed:
    - source: salt://postgresql/postgresql.conf
    - user: postgres
    - group: postgres
    - mode: 0644
    - template: jinja
    - context:
      conn: 300  # max amount of connections
    - require:
      - pkg: postgresql
    - watch_in:
      - service: postgresql

python-psycopg2-pkg:
  pkg.installed:
    - name: python-psycopg2
    - require:
      - pkg: postgresql

postgresql-client:
  pkg.installed

