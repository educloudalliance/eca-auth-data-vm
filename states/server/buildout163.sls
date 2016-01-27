
# Configuration for environment which uses zc.buildout version 1.6.3

include:
  - server.python

buildout-pip-packages:
  pip.installed:
    - names:
      - zc.buildout == 1.6.3
    - require:
      - pkg: python-pip

