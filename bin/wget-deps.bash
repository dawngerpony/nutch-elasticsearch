#!/bin/bash
# wget-deps.bash - download dependencies
ROOTDIR="/vagrant"

. `dirname $0`/setenv.bash

HBASE_URL="http://archive.apache.org/dist/hbase/hbase-$HBASE_VER/$HBASE_ARCHIVE"
ANT_URL="http://mirror.catn.com/pub/apache/ant/binaries/$ANT_ARCHIVE"
NUTCH_URL="http://mirror.gopotato.co.uk/apache/nutch/2.2.1/$NUTCH_ARCHIVE"

cd $ROOTDIR/downloads

if [ ! -f $HBASE_ARCHIVE ]; then
    wget $HBASE_URL
fi

if [ ! -f $ANT_ARCHIVE ]; then
    wget $ANT_URL
fi

if [ ! -f $NUTCH_ARCHIVE ]; then
    wget $NUTCH_URL
fi
