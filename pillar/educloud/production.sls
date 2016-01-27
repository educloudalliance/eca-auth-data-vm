
# These are overwritten in production

educloud:
  vhost: mpass-data.csc.fi
  vhost_connector: mpass-connector.csc.fi
  sentry:
  newrelic_license_key:
  external_sources: |
    AUTH_EXTERNAL_SOURCES = {}
    AUTH_EXTERNAL_ATTRIBUTE_BINDING = {}
    AUTH_EXTERNAL_MUNICIPALITY_BINDING = {}
  db:
    host: 127.0.0.1
    database: data
    user: data
    password: data
  certificates:
    oulu: FIXME
  ssl:
    key:
    cert:
    ca:
