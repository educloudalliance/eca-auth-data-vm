# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "mpass-data-vagrant"

  config.vm.network "public_network"

  ## For masterless, mount your salt file root
  config.vm.synced_folder ".", "/srv/salt/"

  ## Use all the defaults:
  config.vm.provision :salt do |salt|

    salt.minion_config = "minion.conf.vagrant"
    salt.run_highstate = true
    salt.verbose = true

    salt.colorize = true
    salt.log_level = "warning"
    salt.pillar({
      "vagrant" => true,
      "hgrc" => {
        "username" => "foo",
        },
      "educloud" => {
        "vhost" => "mpass-data.local",
        "vhost_connector" => "mpass-connector.local",
        "sentry" => "",
        "newrelic_license_key" => "",
        "django_settings_module" => "local_settings",
        "external_sources" => {
          "AUTH_EXTERNAL_SOURCES" => {},
          "AUTH_EXTERNAL_ATTRIBUTE_BINDING" => {},
          "AUTH_EXTERNAL_MUNICIPALITY_BINDING" => {},
          },
        "db" => {
          "host" => "127.0.0.1",
          "database" => "data",
          "user" => "data",
          "password" => "data",
          },
        "certificates" => {
          "oulu" => "FIXME",
          },
        "ssl" => {
          "key" => "",
          "cert" => "",
          "ca" => "",
          },
        },
      "ssh_known_hosts" => {
        "github.com" => "16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48",
        },
      })

  end

end

