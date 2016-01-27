
include:
  - educloud

git-auth-data:
  git.latest:
    - name: https://github.com/educloudalliance/eca-auth-data.git
    - rev: master
    - target: /home/educloud/data
    - user: educloud
    - require:
      - pkg: git

# local_settings
/home/educloud/data/local_settings.py:
  file.managed:
    - source: salt://educloud/local_settings.py
    - user: educloud
    - group: educloud
    - mode: 0644
    - template: jinja
    - require:
      - git: git-auth-data

# newrelic settings
{% if 'newrelic_license_key' in pillar['educloud'] %}
/home/educloud/data/newrelic.ini:
  file.managed:
    - source: salt://educloud/newrelic.ini
    - user: educloud
    - group: educloud
    - mode: 0644
    - template: jinja
    - require:
      - git: git-auth-data

{% endif %}

deploy-auth-data:
  cmd.wait_script:
    - source: salt://educloud/deploy.sh
    - template: jinja
    - cwd: /home/educloud/data
    - user: educloud
    - group: educloud
    - watch:
      - file: /home/educloud/data/local_settings.py
      - git: git-auth-data


