  notice('MODULAR: fuel-plugin-ceph-kraken/osd_lock.pp')

  file {"/var/log/lost+found/osd_create.lock":
           ensure => 'file',
           path => "/var/log/lost+found/osd_create.lock",
  }
