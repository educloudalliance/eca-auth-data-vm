
base:
  '*':
    - apache
    - educloud
    - educloud.auth_data
    - educloud.oulu
    - locale
    - postgresql
    - server
    - server.buildout163
    - swapfile
    {% if salt['pillar.get']('vagrant', False) %}
    {% else %}
    - users
    - newrelic
    {% endif %}

