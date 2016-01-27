
# -*- coding: utf-8 -*-
# vhost: {{ pillar['educloud']['vhost'] }}
# All changes to this file will be overwritten by salt

from project.settings import *

DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': '{{ pillar['educloud']['db']['database'] }}',
    'HOST': '{{ pillar['educloud']['db']['host'] }}',
    'USER': '{{ pillar['educloud']['db']['user'] }}',
    'PASSWORD': '{{ pillar['educloud']['db']['password'] }}',
  }
}

USE_X_FORWARDED_HOST = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

{% if pillar['educloud']['sentry'] != None -%}
RAVEN_CONFIG = {
  'dsn': '{{ pillar['educloud']['sentry'] }}',
}

INSTALLED_APPS = INSTALLED_APPS + (
    'raven.contrib.django.raven_compat',
)
{% endif %}

# This is fetched from salt pillar
{{ pillar['educloud']['external_sources'] }}

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'root': {
      'level': 'DEBUG',
      'handlers': ['console', 'sentry'],
    },
    'formatters': {
      'normal': {
        'format': '%(asctime)s %(levelname)s %(name)s %(thread)d %(lineno)s %(message)s %(data)s'
      },
      'verbose': {
        'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s %(data)s'
      },
    },
    'filters': {
      'default': {
        '()': 'project.logging_helpers.Filter',
      },
    },
    'handlers': {
      'sentry': {
        'level': 'WARNING',
        'class': 'raven.contrib.django.handlers.SentryHandler',
      },
      'console': {
        'level': 'DEBUG',
        'class': 'logging.StreamHandler',
        'formatter': 'verbose',
        'filters': ['default'],
      },
    },
    'loggers': {
      'sentry.errors': {
        'level': 'DEBUG',
        'handlers': ['console'],
        'propagate': False,
      },
      'django': {
        'level': 'WARNING',
        'handlers': ['console', 'sentry'],
        'propagate': True,
      },
      '': {
        'handlers': ['console', 'sentry'],
        'level': 'DEBUG',
        'propagate': False,
      },
    },
}

# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2
