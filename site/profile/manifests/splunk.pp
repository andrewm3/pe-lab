# profile::splunk
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::splunk
class profile::splunk {
  class { '::splunk':
    httpport           => 8000,
    kvstoreport        => 8191,
    inputport          => 9997,
    reuse_puppet_certs => false,
    sslcertpath        => 'server.pem',
    sslrootcapath      => 'cacert.pem',
  }
}
