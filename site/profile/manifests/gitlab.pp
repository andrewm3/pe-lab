# Install Gitlab CE (Community Edition).
#
# @example
#   class { 'profile::gitlab':
#     server_name => 'gitlab.example.com',
#   }
#
class profile::gitlab (
  String $server_name      = $facts['fqdn'],
  String $ca_file_source   = 'file:///etc/puppetlabs/puppet/ssl/certs/ca.pem',
  String $key_file_source  = "file:///etc/puppetlabs/puppet/ssl/private_keys/${trusted['certname']}.pem",
  String $cert_file_source = "file:///etc/puppetlabs/puppet/ssl/certs/${trusted['certname']}.pem",
) {

  $ssl_certificate     = "/etc/gitlab/ssl/${server_name}.crt"
  $ssl_certificate_key = "/etc/gitlab/ssl/${server_name}.key"

  class { 'gitlab':
    external_url => "https://${server_name}",
    nginx        => {
      redirect_http_to_https => true,
      ssl_certificate        => $ssl_certificate,
      ssl_certificate_key    => $ssl_certificate_key,
    },
  }

  file { ['/etc/gitlab/ssl', '/etc/gitlab/trusted-certs']:
    ensure  => directory,
    require => Class['gitlab::install'],
  }

  file { $ssl_certificate:
    ensure => file,
    source => $cert_file_source,
    before => Class['gitlab::service'],
  }

  file { $ssl_certificate_key:
    ensure => file,
    source => $key_file_source,
    mode   => '0400',
    before => Class['gitlab::service'],
  }

  file { '/etc/gitlab/trusted-certs/ca_bundle.crt':
    ensure => file,
    source => $ca_file_source,
    before => Class['gitlab::service'],
  }
}
