
newrelic-ppa:
  pkgrepo.managed:
    - human_name: New Relic PPA
    - name: deb http://apt.newrelic.com/debian/ newrelic non-free
    - key_url: https://download.newrelic.com/548C16BF.gpg
    - require:
      - cmd: install-newrelic-repo-key-cmd

newrelic-sysmond:
  pkg.installed:
    - skip_verify: True
    - require:
      - pkgrepo: newrelic-ppa
  service.running:
    - watch:
      - pkg: newrelic-sysmond

newrelic-sysmond-conf:
  file.managed:
    - name: /etc/newrelic/nrsysmond.cfg
    - source: salt://newrelic/nrsysmond.cfg.jinja
    - template: jinja
    - require:
      - pkg: newrelic-sysmond
    - require_in:
      - service: newrelic-sysmond
    - watch_in:
      - service: newrelic-sysmond

/etc/apt/newrelic_repo.gpg:
  file.managed:
    - source: salt://newrelic/newrelic_public_key.gpg
    - user: root
    - group: root
    - mode: 0644

install-newrelic-repo-key-cmd:
  cmd.run:
    - name: apt-key add /etc/apt/newrelic_repo.gpg
    - onchanges:
      - file: /etc/apt/newrelic_repo.gpg

