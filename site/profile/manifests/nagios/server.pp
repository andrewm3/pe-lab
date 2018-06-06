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

  package { ['nagios', 'nagios-plugins', 'nagios-plugins-all']:
    ensure => present,
  }

  file { '/etc/nagios/conf.d':
    ensure  => directory,
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0755',
    require => Package['nagios'],
  }

  # apache config for nagios
  file { '/etc/httpd/conf.d/nagios.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('profile/nagios/nagios.conf.epp'),
    require => Package['nagios'],
  }

  service { 'nagios':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/httpd/conf.d/nagios.conf'],
  }

  firewall { '100 Nagios HTTP 80':
    dport  => '80',
    proto  => 'tcp',
    action => 'accept',
  }

  Nagios_host <<||>>
  Nagios_service <<||>>
}
