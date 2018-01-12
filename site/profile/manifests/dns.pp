# profile::dns
#
# Configure 'DNS' - with the export host resource and collect method
#
class profile::dns (
  Array[String] $host_aliases = [],
) {

  host { 'localhost':
    ensure => present,
    ip     => '127.0.0.1',
  }

  @@host { $facts['fqdn']:
    ensure       => present,
    host_aliases => $host_aliases + $facts['hostname'],
    ip           => $facts['ipaddress'],
  }

  # Collect all exported host resources
  Host <<| |>>
}
