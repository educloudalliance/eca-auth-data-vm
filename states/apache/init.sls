
include:
  - server.libs

apache2:
  pkg.installed:
    - name: apache2
  service:
    - name: apache2
    - enable: True
    - running
    - require:
      - pkg: apache2

apache2-modules:
  apache_module.enable:
    - names:
      - alias
      - expires
      - headers
      - proxy
      - proxy_http
      - proxy_connect
      - rewrite
      - ssl
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/000-default.conf:
  file.managed:
    - source: salt://apache/vhost-default.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/etc/apache2/sites-enabled/001-vhost-data.conf:
  file.managed:
    - source: salt://apache/vhost-data.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

# Tighten SSL security
/etc/apache2/mods-available/ssl.conf:
  file.managed:
    - source: salt://apache/ssl.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2

/var/www:
  file.recurse:
    - source: salt://apache/www
    - user: root
    - group: root
    - clean: true
    - file_mode: 644
    - dir_mode: 755
    - template: jinja
    - require:
      - pkg: apache2

/etc/pki/educloud:
  file.directory:
    - makedirs: true

{% if salt['pillar.get']('vagrant', False) %}
/etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.key:
  x509.private_key_managed:
    - require:
      - file: /etc/pki/educloud

/etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.crt:
  x509.certificate_managed:
    - signing_private_key: /etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.key
    - C: FI
    - ST: Pirkanmaa
    - L: Tampere
    - emailAddress: admin@haltu.fi
    - days_valid: 3650
    - require:
      - x509: /etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.key
    - require_in:
      - service: apache2

{% else %}

# In production ssl certs are fetched from pillar
/etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.key:
  file.managed:
    - mode: 640
    - contents_pillar: educloud:ssl:key
    - require:
      - file: /etc/pki/educloud
    - watch_in:
      - service: apache2

/etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.crt:
  file.managed:
    - mode: 644
    - contents_pillar: educloud:ssl:cert
    - require:
      - file: /etc/pki/educloud
    - watch_in:
      - service: apache2

/etc/pki/educloud/{{ pillar['educloud']['vhost'] }}.ca:
  file.managed:
    - mode: 644
    - contents_pillar: educloud:ssl:ca
    - require:
      - file: /etc/pki/educloud
    - watch_in:
      - service: apache2

{% endif %}

