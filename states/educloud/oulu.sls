
edusrv26.eduouka.fi:
  host.present:
    - ip: 85.194.218.156

/home/educloud/data/oulu_certificate:
  file.managed:
    - mode: 644
    - user: educloud
    - group: educloud
    - contents_pillar: educloud:certificates:oulu

