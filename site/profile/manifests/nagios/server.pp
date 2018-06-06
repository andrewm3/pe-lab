# Install Nagios Core.
#
# @example
#   include profile::nagios::server
#
class profile::nagios::server {

  require epel
  require apache
  require apache::mod::ssl
  require apache::mod::php

  class { 'selinux':
    mode => 'permissive',
    type => 'targeted',
  }

  package { ['nagios', 'nagios-plugins', 'nagios-plugins-all']:
    ensure => present,
  }
}
