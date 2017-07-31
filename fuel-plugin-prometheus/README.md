fuel-plugin-prometheus
============

fuel-plugin-prometheus implements Prometheus monitoring with multiple exporters in Fuel-9.2 environment
with Grafana dashboard (optionally)

Compatible Fuel versions
------------------------

9.2


User Guide
----------

1. Create an environment.
2. Enable the plugin on the Settings/Other tab of the Fuel web UI and fill in form
3. Enable desired exporters
4. Configure other settings of environment
5. Deploy the environment.


Installation Guide
==================

Ceph Prometheus Plugin for Fuel installation
----------------------------------------------

To install Ceph Prometheus plugin, follow these steps:

1. Download the plugin
    git clone https://github.com/fastjohnny/Fuel-Plugins.git

2. Build the plugin (you will need fuel-plugin-builder)
   fpb --build ./fuel-plugin-prometheus

2. Copy the plugin on already installed Fuel Master node; ssh can be used for
    that. If you do not have the Fuel Master node yet, see
    [Quick Start Guide](https://software.mirantis.com/quick-start/):

        # scp fuel-plugin-prometheus-1.0.1-1.noarch.rpm root@<Fuel_master_ip>:/tmp

3. Log into the Fuel Master node. Install the plugin:

        # cd /tmp
        # fuel plugins --install fuel-plugin-prometheus-1.0.1-1.noarch.rpm

4. Check if the plugin was installed successfully:

        # fuel plugins
        id | name                            | version | package_version
        ---|---------------------------------|---------|----------------
        1  | fuel-plugin-prometheus          | 1.0.1   | 4.0.0

Requirements
------------

| Requirement                      | Version/Comment |
|:---------------------------------|:----------------|
| Mirantis OpenStack compatibility | 9.2             |


Limitations
-----------

Currently, this plugin can be used only on Fuel9/9.2 release


Contacts
--------

Roman Klimenko roman9100@mail.ru

