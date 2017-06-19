 notice('MODULAR: fuel-plugin-ceph-kraken/repo_del.pp')
 Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }
 exec { "comment kraken repo":
         command => 'sed -i "/^deb.*/ s/^#*/#/" /etc/apt/sources.list.d/fuel-plugin-ceph-kraken-* && apt-get update',
 }
 

