 notice('MODULAR: fuel-plugin-ceph-kraken/keys.pp')

 exec { "gather keys":
         command => "ceph-deploy --ceph-conf ~/ceph.conf gatherkeys localhost",
         path    => "/usr/bin",
 }
