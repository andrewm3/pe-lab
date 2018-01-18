# profile::yumrepo
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::yumrepo
#
class profile::yumrepo (
  Boolean            $enable_firewall = true,
  String             $repository_dir  = '/var/www/html/yumrepo',
  String             $repo_cache_dir  = '/var/cache/yumrepo',
  Hash[String, Hash] $yumrepos        = {},
) {

  file { [$repository_dir, $repo_cache_dir]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  $yumrepos.each |$yumrepo_name, $yumrepo_attributes| {
    createrepo { $yumrepo_name:
      repository_dir => "${repository_dir}/${yumrepo_name}",
      repo_cache_dir => "${repo_cache_dir}/${yumrepo_name}",
      *              => $yumrepo_attributes,
    }

    file { "${repository_dir}/${yumrepo_name}/RPMS":
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }

  include ::apache::mod::autoindex

  apache::vhost { $facts['fqdn']:
    port    => 80,
    docroot => '/var/www/html/yumrepo',
  }

  if $enable_firewall {
    firewall { '100 yumrepo HTTP 80':
      dport  => '80',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
