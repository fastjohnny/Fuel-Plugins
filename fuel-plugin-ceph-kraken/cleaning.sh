#!/bin/bash

DIR=`dirname $0`

#OPTIONAL cleaning to defaul manifests

CEPHDIR='/etc/puppet/modules/ceph/manifests'
CEPHOSDSDIR='/etc/puppet/modules/ceph/manifests/osds'
CEPHOSNAILYDIR='/etc/puppet/modules/osnailyfacter/manifests/ceph'
#cleaning

mv $CEPHDIR/conf.pp.backup $CEPHDIR/conf.pp
mv $CEPHDIR/radosgw.pp.backup $CEPHDIR/radosgw.pp
mv $CEPHDIR/mon.pp.backup $CEPHDIR/mon.pp
mv $CEPHDIRo/osds.pp.backup $CEPHDIR/osds.pp
mv $CEPHOSDSDIR/osd.pp.backup $CEPHOSDSDIR/osd.pp
mv $CEPHOSNAILYDIR/ceph_compute.pp.backup $CEPHOSNAILYDIR/ceph_compute.pp

rm -rf $CEPHOSDSDIR/*.rej
rm -rf $CEPHDIR/*.rej
rm -rf $CEPHOSNAILYDIR/*.rej
rm -rf /etc/puppet/modules/ceph/lib/puppet/parser/
