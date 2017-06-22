#!/bin/bash

DIR=`dirname $0`

#OPTIONAL cleaning to defaul manifests

CEPHDIR='/etc/puppet/modules/ceph/manifests'
CEPHOSDSDIR='/etc/puppet/modules/ceph/manifests/osds'

#cleaning

mv $CEPHDIR/conf.pp.backup $CEPHDIR/conf.pp
mv $CEPHDIR/radosgw.pp.backup $CEPHDIR/radosgw.pp
mv $CEPHDIR/mon.pp.backup $CEPHDIR/mon.pp
mv $CEPHOSDSDIR/osd.pp.backup $CEPHOSDSDIR/osd.pp

rm -rf $CEPHOSDSDIR/*.rej
rm -rf $CEPHDIR/*.rej
