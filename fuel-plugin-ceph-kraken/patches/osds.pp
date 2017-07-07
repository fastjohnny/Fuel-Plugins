# == Class: ceph::osd
#
# Prepare and bring online the OSD devices
#
# ==== Parameters
#
# [*devices*]
# (optional) Array. This is the list of OSD devices identified by the facter.
#
class ceph::osds (
  $devices = $::ceph::osd_devices,
){

  #added conditional for right kraken ceph osd deployment
  $fuel_plugin_ceph_kraken = hiera_hash('fuel-plugin-ceph-kraken', {})
  $bluestore = pick($fuel_plugin_ceph_kraken['bluestore'], false)

  exec { 'udevadm trigger':
    command     => 'udevadm trigger',
    returns     => 0,
    logoutput   => true,
  } 

  exec {'ceph-disk activate-all':
    command     => 'ceph-disk activate-all',
    returns     => [0, 1],
    logoutput   => true,
  }

  firewall { '011 ceph-osd allow':
    chain  => 'INPUT',
    dport  => '6800-7100',
    proto  => 'tcp',
    action => accept,
  } 
  if $bluestore == true {
     $node_volumes = hiera('node_volumes')
     $dev = get_target_disk($node_volumes, 'ceph')
     $min_blck_size = get_ceph_size($dev)
     ceph_conf {
        'global/bluestore_block_size':                     value => $min_blck_size;
     }
     Exec['udevadm trigger']->
       Exec['ceph-disk activate-all'] ->
         Firewall['011 ceph-osd allow']->
           Ceph_conf[['global/bluestore_block_size']]-> ceph::osds::osd{ $devices: }
  }
  else {
    Exec['udevadm trigger']->
      Exec['ceph-disk activate-all'] ->
        Firewall['011 ceph-osd allow'] -> ceph::osds::osd{ $devices: }
  }
}
