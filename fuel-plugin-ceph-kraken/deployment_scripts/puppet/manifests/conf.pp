 notice('MODULAR: fuel-plugin-ceph-kraken/conf.pp')

   Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }
   $plugin_settings = hiera('fuel-plugin-ceph-kraken')
   $bluestore = $plugin_settings['bluestore']
   #adding symlink for kraken ceph
   file { "ceph link":
     path => '/etc/ceph/ceph.client.admin.keyring',
     ensure => 'link',
     target => '/root/ceph.client.admin.keyring',
   } ->
   exec {"restart ceph-osd":
     command => "stop ceph-all && start ceph-all",
   }
#   if $bluestore == true {
#
#   ceph_conf {
#     'osd/enable_experimental_unrecoverable_data_corrupting_features' : value => bluestore;
#   } ->
#   exec { "Stop all ceph services":
#             command => "stop ceph-all"
#        }
#   ->
#   exec { "Activate OSD $name":
#             command => "start ceph-all",
#        }
#   }
