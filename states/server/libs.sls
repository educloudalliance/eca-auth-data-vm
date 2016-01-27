
essential-libs-packages:
  pkg.installed:
    - names:
      - python-dev
      - libffi-dev
      - libssl-dev
      - python-m2crypto

pyOpenSSL:
  pip.installed:
    - name: pyOpenSSL == 0.15.1
    - require:
      - pkg: libffi-dev
      - pkg: libssl-dev
