# elasticsearch

class elasticsearch {
    file { "/etc/yum.repos.d/elasticsearch.repo":
        ensure => file,
        source => "puppet:///modules/elasticsearch/elasticsearch.repo"
    }
    package { "elasticsearch" :
        ensure => present,
        provider => rpm,
        source => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.noarch.rpm",
    }

    service { "elasticsearch":
        enable => true,
        ensure => running,
        #hasrestart => true,
        #hasstatus => true,
        require => Package["elasticsearch"],
    }
}
