class fuel-plugin-ceph-kraken::ceph_key {

  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }
  $plugin_settings = hiera('fuel-plugin-ceph-kraken')
  $ceph_key_file     = "/tmp/release.asc"
 
  file { $ceph_key_file :
    source      => "puppet:///modules/fuel-plugin-ceph-kraken/release.asc",
    notify      => Exec["adding ceph team key"],
  }

  exec { "adding ceph team key":
                 command => "apt-key add $ceph_key_file",
  }
}
