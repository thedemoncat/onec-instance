#!/bin/bash

rm -rf /run/apachectl/* /tmp/apachectl*

echo apachectl running
apachectl -DFOREGROUND &

echo ragent running
gosu usr1cv8 ragent -d $ONEC_DATA $@
