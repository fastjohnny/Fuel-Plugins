#!/bin/bash

DIR=`dirname $0`

mkdir -p /etc/puppet/modules/ceph/lib/puppet/parser/functions/
cp ${DIR}/get_ceph_size.rb ${DIR}/get_target_disk.rb /etc/puppet/modules/ceph/lib/puppet/parser/functions/

#fuel 9.2 ceph manifests core library patching for Kraken compatibility

CEPHDIR='/etc/puppet/modules/ceph/manifests'
CEPHOSDSDIR='/etc/puppet/modules/ceph/manifests/osds'
CEPHOSNAILYDIR='/etc/puppet/modules/osnailyfacter/manifests/ceph'
#backing up

cp -n $CEPHDIR/conf.pp $CEPHDIR/conf.pp.backup
cp -n $CEPHDIR/radosgw.pp $CEPHDIR/radosgw.pp.backup
cp -n $CEPHDIR/mon.pp $CEPHDIR/mon.pp.backup
cp -n $CEPHDIR/osds.pp $CEPHDIR/osds.pp.backup
cp -n $CEPHOSDSDIR/osd.pp $CEPHOSDSDIR/osd.pp.backup
cp -n $CEPHOSNAILYDIR/ceph_compute.pp $CEPHOSNAILYDIR/ceph_compute.pp.backup

#patch
patch -N $CEPHDIR/conf.pp ${DIR}/conf.patch
patch -N $CEPHDIR/radosgw.pp ${DIR}/radosgw.patch
patch -N $CEPHDIR/mon.pp ${DIR}/mon.patch
patch -N $CEPHDIR/osds.pp ${DIR}/osds.patch
patch -N $CEPHOSDSDIR/osd.pp ${DIR}/osd.patch
patch -N $CEPHOSNAILYDIR/ceph_compute.pp ${DIR}/ceph_compute.patch
