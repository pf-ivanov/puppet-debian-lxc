#!/bin/bash -x

myid=GGHKEFWETYF747T9P
if [ "x`grep $myid runme.sh 2>/dev/null`" == "x" ]; then
    echo "Must run from my directory"
    exit 1
fi

sudo /opt/puppetlabs/bin/puppet apply -vt --modulepath=modules . $@
