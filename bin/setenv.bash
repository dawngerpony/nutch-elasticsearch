#!/bin/bash
HBASE_VER="0.90.4"
ANT_VER="1.9.4"
NUTCH_VER="2.2.1"

HBASE_ARCHIVE="hbase-$HBASE_VER.tar.gz"
ANT_ARCHIVE="apache-ant-$ANT_VER-bin.tar.gz"
NUTCH_ARCHIVE="apache-nutch-$NUTCH_VER-src.tar.gz"
ARCHIVES="$HBASE_ARCHIVE $ANT_ARCHIVE $NUTCH_ARCHIVE"

SRCROOT="/vagrant"
APPROOT="/opt"
