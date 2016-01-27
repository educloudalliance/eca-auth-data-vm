
essential-packages:
  pkg.installed:
    - names:
      - python-pip
      - python-psycopg2
      - python-imaging
      - python-lxml # TODO Really needed on all servers?
      - python-virtualenv

essential-pip-packages:
  pip.installed:
    - names:
      - python-memcached
    - require:
      - pkg: python-pip

# This file needs also one of the buildout states. The buildout states are separated
# from this one to allow installation of different versions.  We do not want to variate
# every single package version so the buildout version is the decisive factor.

