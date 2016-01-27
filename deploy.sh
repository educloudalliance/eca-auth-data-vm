#!/bin/sh

apt-get install python-software-properties
add-apt-repository ppa:saltstack/salt2015-5
apt-get update
apt-get install python-pip
apt-get install salt-minion

mkdir /srv/pillar

ln -s /srv/salt/minion.conf /etc/salt/minion.d/haltu.conf

salt-call --local state.highstate test=True
