#!/bin/bash

DIR=`dirname $0`

#fuel 9.2 ceph manifests core library patching for Kraken compatibility

CEPHDIR='/etc/puppet/modules/ceph/manifests'
CEPHOSDSDIR='/etc/puppet/modules/ceph/manifests/osds'

#backing up

cp -n $CEPHDIR/conf.pp $CEPHDIR/conf.pp.backup
cp -n $CEPHDIR/radosgw.pp $CEPHDIR/radosgw.pp.backup
cp -n $CEPHDIR/mon.pp $CEPHDIR/mon.pp.backup
cp -n $CEPHOSDSDIR/osd.pp $CEPHOSDSDIR/osd.pp.backup

#patch

patch -N $CEPHDIR/conf.pp ${DIR}/conf.patch
patch -N $CEPHDIR/radosgw.pp ${DIR}/radosgw.patch
patch -N $CEPHDIR/mon.pp ${DIR}/mon.patch
patch -N $CEPHOSDSDIR/osd.pp ${DIR}/osd.patch
