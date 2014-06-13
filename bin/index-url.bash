#!/bin/bash
# index-url.bash - index a file of URLs

TOPN="10"

if [ $# -ne 1 ]; then
    echo "Error: insufficient parameters"
    echo "Usage: $0 <URL file>"
    exit 1
fi

if [ ! $NUTCH_HOME ]; then
    NUTCH_HOME="/opt/nutch"
    echo "!!! NUTCH_HOME not set, defaulting to $NUTCH_HOME"
fi

if [ ! $JAVA_HOME ]; then
    export JAVA_HOME="/etc/alternatives/java_sdk"
fi

urlfile="$(readlink -f $1)"
urldir="urls"
ts=`date +%Y%m%d%H%M%S`

cd $NUTCH_HOME/runtime/local

if [ -d $urldir ]; then
    mv $urldir $urldir.bak-$ts
fi

echo "*** Copying $urlfile to $urldir"
cp $urlfile $urldir

echo "*** Running nutch crawl processes..."
echo "*** inject"
bin/nutch inject urls/ || exit 1
echo "*** generate"
bin/nutch generate -topN $TOPN || exit 1
echo "*** fetch"
bin/nutch fetch -all || exit 1
echo "*** parse"
bin/nutch parse -all || exit 1
echo "*** updatedb"
bin/nutch updatedb || exit 1

echo "*** indexing into elasticsearch"
bin/nutch elasticindex elasticsearch -all || exit 1
