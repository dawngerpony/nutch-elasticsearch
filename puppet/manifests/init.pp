# init.pp - Puppet manifest

class base {

    # nutch and elasticsearch both need Java; 
    # we specifically need the JDK rather than the JRE in order to build nutch.
    package { "java-1.7.0-openjdk-devel.x86_64":
        ensure => installed,
    }

    # ensure that we can patch the nutch source code
    package { "patch":
        ensure => installed,
    }

    # ensure that we can patch the nutch source code
    package { "httpd":
        ensure => installed,
    }

    # Create a bigdesk directory for the BigDesk app
    file { "/var/www/html/bigdesk":
        ensure => directory,
        require => Package["httpd"]
    }

    service { "httpd":
        enable => true,
        ensure => running,
        #hasrestart => true,
        #hasstatus => true,
        require => Package["httpd"],
    }

    # allow anyone to install stuff into /opt
    file { "/opt":
        ensure => directory,
        mode => 0777
    }

    # disable the firewall so that nutch can find elasticsearch
    service { "iptables":
        enable => false,
        ensure => stopped,
    }
}

class pip_modules {

    package { "python-pip":
        ensure => installed,
    }
    $pip_packages = [
        "requests",
        "simplejson"
    ]
    package { $pip_packages:
        ensure => installed,
        provider => pip,
        require => Package["python-pip"]
    }
}

include epel
include base
include elasticsearch
include pip_modules

Class['epel'] -> Class['pip_modules']
Class['epel'] -> Class['base']
