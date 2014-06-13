nutch-elasticsearch
===================

A prototype system to integrate nutch 2.2 with elasticsearch 1.1 and hbase 0.90.

Installation
------------

1. Fire up vagrant:

        vagrant up
        vagrant ssh
        cd /vagrant
        
1. Download ant, nutch and hbase:

        bin/wget-deps.bash

1. Check elasticsearch is running:

        curl http://localhost:9200

1. Start elasticsearch and create an index:

        curl -XPUT http://localhost:9200/nutch/

1. Run `build-nutch.bash` to build using ant/ivy and install config file:

        /vagrant/build-nutch.bash

1. Start hbase:

        /opt/hbase-0.90.4/bin/start-hbase.sh

1. (Optional) Install [BigDesk](http://bigdesk.org/):
    1. Download: https://github.com/lukas-vlcek/bigdesk/tarball/master
    1. Extract BigDesk into `/var/www/html/bigdesk`
    1. Visit the app: http://localhost:8080/bigdesk/

1. Run the nutch crawler:

        cd /opt/apache-nutch-2.2.1/runtime/local
        /vagrant/bin/index-url.bash /vagrant/conf/urls.txt

1. Test:

        bin/nutch readdb -url `cat urls/urls.txt`

1. Index into elasticsearch:

        bin/nutch elasticindex elasticsearch -all


Helpful Information
-------------------

* the crawldb is stored in hbase.

nutch commands
--------------

Simplest crawling:

    cd runtime/local
    echo "http://www.kusiri.com" > urls/urls.txt
    bin/nutch inject urls/
    bin/nutch generate -topN 1
    bin/nutch fetch -all
    bin/nutch parse -all
    bin/nutch updatedb

    bin/nutch elasticindex elasticsearch -all


elasticsearch sense commands
----------------------------

    GET /nutch/_search
    
hbase commands
--------------

Open a shell:
    
    ~/hbase/bin/hbase shell

Get help (from inside the shell):

    hbase(main):001:0> help

List all tables:

    hbase(main):001:0> list

Delete (i.e. disable then drop) the 'webpage' table:

    hbase(main):002:0> disable 'webpage'
    hbase(main):004:0> drop 'webpage'

Leave the shell:

    hbase(main):002:0> exit

elasticsearch commands
----------------------

[create index](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-create-index.html):

    curl -XPUT 'http://localhost:9200/twitter/'

[nodes stats](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/cluster-nodes-stats.html):

    curl -XGET 'http://localhost:9200/_nodes/stats'

Troubleshooting
---------------

### ClusterBlockException

    [vagrant@localhost local]$ bin/nutch elasticindex elasticsearch -all
    Exception in thread "elasticsearch[Caiera][generic][T#2]" org.elasticsearch.cluster.block.ClusterBlockException: blocked by: [SERVICE_UNAVAILABLE/1/state not recovered / initialized];[SERVICE_UNAVAILABLE/2/no master];
        at org.elasticsearch.cluster.block.ClusterBlocks.globalBlockedException(ClusterBlocks.java:138)
        at org.elasticsearch.cluster.block.ClusterBlocks.globalBlockedRaiseException(ClusterBlocks.java:128)
        at org.elasticsearch.action.bulk.TransportBulkAction.executeBulk(TransportBulkAction.java:197)
        at org.elasticsearch.action.bulk.TransportBulkAction.access$000(TransportBulkAction.java:65)
        at org.elasticsearch.action.bulk.TransportBulkAction$1.onFailure(TransportBulkAction.java:143)
        at org.elasticsearch.action.support.TransportAction$ThreadedActionListener$2.run(TransportAction.java:117)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615)
        at java.lang.Thread.run(Thread.java:744)

Check the following:
* Your elasticsearch configuration is correct.
* Your firewall is disabled:

        sudo service iptables stop
        sudo chkconfig iptables off



References
----------

* [NutchTutorial](http://wiki.apache.org/nutch/NutchTutorial)
* [Nutch2Tutorial](http://wiki.apache.org/nutch/Nutch2Tutorial)
* [Nutch 2 and ElasticSearch](http://www.sigpwned.com/content/nutch-2-and-elasticsearch) - helpful blog post
** [Integrating Nutch 1.7 with ElasticSearch](https://www.mind-it.info/integrating-nutch-1-7-elasticsearch/)
* [NUTCH-1745](https://issues.apache.org/jira/browse/NUTCH-1745) - Upgrade to ElasticSearch 1.1.0
* [1.2. Quick Start](http://hbase.apache.org/book/quickstart.html) - hbase user manual
* [Hbase/Shell](https://wiki.apache.org/hadoop/Hbase/Shell) - from the Hadoop wiki
