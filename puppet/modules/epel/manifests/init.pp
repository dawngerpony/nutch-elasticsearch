# EPEL yum repo

class epel {
    package { "epel-release" :
        ensure => present,
        provider => rpm,
        source => "http://mirrors.coreix.net/fedora-epel/6/i386/epel-release-6-8.noarch.rpm",
    }
    exec { "yum-config-manager --enable epel":
        command => "yum-config-manager --enable epel",
        require => Package["epel-release"],
        unless => "yum --cacheonly repolist | grep epel",
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        #refreshonly => true,
    }
}
