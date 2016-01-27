# Virtual machine for Django and python based Educloud Alliance development #

The repo contains Vagrant and Salt configuration for running development machine.

## How do I get set up? ##

First you need a bare metal machine running Vagrant 1.7.2.
Other versions might work but are not actively tested.

Then you say ``vagrant up`` and wait for it to finish.

## What do I get? ##

The machine up and running with:

* virtualenv
* zc.buildout
* Python environment
* Local PosgreSQL server
* Auth Data service
