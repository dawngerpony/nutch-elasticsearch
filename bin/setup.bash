#!/bin/bash
# setup.bash:
#  - extract ant, nutch and hbase to /opt

. `dirname $0`/setenv.bash

DOWNLOADS="$SRCROOT/downloads"

cd /opt

NUTCH_HOME="/$APPROOT/apache-nutch-$NUTCH_VER"
if [ ! -d $NUTCH_HOME ]; then
    echo "Nutch missing"
    if [ -f $DOWNLOADS/$NUTCH_ARCHIVE ]; then
        echo "Extracting nutch archive $NUTCH_ARCHIVE..."
        cd $APPROOT
        tar -xzf $DOWNLOADS/$NUTCH_ARCHIVE
        echo "done."
    else
        echo "Need to download nutch, run wget-deps.bash"
        exit 1
    fi
fi
ln -nsf $NUTCH_HOME $APPROOT/nutch

ANT_HOME="$APPROOT/apache-ant-$ANT_VER"
if [ ! -d $ANT_HOME ]; then
    echo "Ant missing"
    if [ -f $DOWNLOADS/$ANT_ARCHIVE ]; then
        echo "Extracting ant archive $ANT_ARCHIVE..."
        cd $APPROOT
        tar -xzf $DOWNLOADS/$ANT_ARCHIVE
        echo "done."
    else
        echo "Need to download ant, run wget-deps.bash"
        exit 1
    fi
fi
ln -nsf $ANT_HOME $APPROOT/ant

HBASE_HOME="$APPROOT/hbase-$HBASE_VER"
if [ ! -d $HBASE_HOME ]; then
    echo "hbase missing"
    if [ -f $DOWNLOADS/$HBASE_ARCHIVE ]; then
        echo "Extracting hbase archive $HBASE_ARCHIVE..."
        cd $APPROOT
        tar -xzf $DOWNLOADS/$HBASE_ARCHIVE
        echo "done."
    else
        echo "Need to download hbase, run wget-deps.bash"
        exit 1
    fi
fi
ln -nsf $HBASE_HOME $APPROOT/hbase

echo "Now:"
echo " 1. Start hbase: /opt/hbase/bin/start-hbase.sh"
echo " 2. Build nutch: /vagrant/bin/build-nutch.bash"
echo " 3. Index a file of URLs: /vagrant/bin/index-url.bash /vagrant/conf/urls.txt"
