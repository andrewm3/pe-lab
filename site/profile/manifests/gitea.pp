# profile::gitea
#
# Manage a Gitea installation.
#
# @example
#   include profile::gitea
#
class profile::gitea (
  String  $server_protocol  = 'http',
  String  $server_domain    = $facts['fqdn'],
  Integer $server_http_port = 3000,
  String  $server_root_url  = "${server_protocol}://${server_domain}/",
) {

  class { '::gitea':
    configuration_sections => {
      'server' => {
        'PROTOCOL'  => $server_protocol,
        'DOMAIN'    => $server_domain,
        'HTTP_PORT' => $server_http_port,
        'ROOT_URL'  => $server_root_url,
      },
    }
  }

  include ::nginx

  nginx::resource::server { $server_domain:
    listen_port => 80,
    proxy       => "${server_protocol}://${server_domain}:${server_http_port}"
  }
}
