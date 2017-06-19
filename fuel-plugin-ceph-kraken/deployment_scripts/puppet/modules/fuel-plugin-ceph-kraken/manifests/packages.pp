class fuel-plugin-ceph-kraken::packages {

  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }

  exec { "uncomment kraken repo":
                 command => "sed -i 's/^#deb/deb/g' /etc/apt/sources.list.d/fuel-plugin-ceph-kraken-* && apt update",
  }->
  exec { "force install of nonauthenticated ceph_base and ceph-deploy packages":
                 command => "env DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get --assume-yes --force-yes -q --no-install-recommends install -o Dpkg::Options::=--force-confnew ceph-base ceph-deploy",
  }->
  exec { "force install of nonauthenticated ceph packages":
                 command => "env DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get --assume-yes --force-yes -q --no-install-recommends install -o Dpkg::Options::=--force-confnew ceph-osd ceph-mds ceph-mon radosgw",
  }->
  exec {"chown ceph":
                 command => 'chown ceph:ceph -R /var/lib/ceph && chown ceph:ceph -R /var/log/ceph',
  }->
  exec {"restart ceph":
                 command => 'stop ceph-all && start ceph-all',
  }
}
