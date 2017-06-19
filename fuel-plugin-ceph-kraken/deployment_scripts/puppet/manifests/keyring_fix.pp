notice('MODULAR: fuel-plugin-ceph-kraken/keyring_fix.pp')
Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }


  file_line {'correct mon cap':
         path => '/etc/ceph/ceph.mon.keyring',
         line => 'caps mon = "allow *"',
         match => 'caps mon = allow *',
  }
->
  exec {"restart ceph":
                 command => 'stop ceph-all && start ceph-all',
  }
->
  exec {"update mon cap":
                 command => 'ceph auth caps client.admin osd "allow *" mds "allow *" mon "allow *"',
  }
