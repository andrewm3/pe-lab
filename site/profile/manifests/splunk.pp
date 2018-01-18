# profile::splunk
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::splunk
class profile::splunk (
  Boolean $enable_firewall = true,
  String  $yumrepo_baseurl = 'http://yumrepo.openstack.vm/splunk',
) {

  yumrepo { 'splunk':
    baseurl  => $yumrepo_baseurl,
    descr    => 'Splunk private repository',
    enabled  => 1,
    gpgcheck => 0,
  }

  class { '::splunk':
    service            => {
      enable => true,
      ensure => running,
    },
    httpport           => 8000,
    kvstoreport        => 8191,
    inputport          => 9997,
    reuse_puppet_certs => false,
    sslcertpath        => 'server.pem',
    sslrootcapath      => 'cacert.pem',
    require            => Yumrepo['splunk'],
  }

  if $enable_firewall {
    firewall { '100 Splunk HTTPS 8000':
      dport  => '8000',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
