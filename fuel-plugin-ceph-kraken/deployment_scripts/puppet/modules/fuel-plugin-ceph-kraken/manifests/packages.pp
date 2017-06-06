class fuel-plugin-ceph-kraken::packages {

 Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }

  exec { "force install of nonauthenticated ceph packages":
                 command => "env DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get --assume-yes --force-yes -q --no-install-recommends install -o Dpkg::Options::=--force-confnew ceph-osd ceph-mds ceph-mon radosgw",
  }
}
