#!/bin/bash
DIR=`dirname $0`
rpm -qa | grep "^patch.*"
PACKAGEPRESENT=$?

if [[ "$PACKAGEPRESENT" == "1" ]]
  then echo "RPM Package patch is needed";
  exit 1
elif [[ "$PACKAGEPRESENT" == "0" ]]
  then /bin/bash /var/www/nailgun/plugins/fuel-plugin-ceph-kraken-*/patches/apply.sh
  echo "patched"
fi
