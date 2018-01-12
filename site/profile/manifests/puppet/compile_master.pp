# profile::puppet::compile_master
#
# Configure a PE compile master.
#
class profile::puppet::compile_master {
  @@haproxy::balancermember { "master00-${facts['fqdn']}":
    listening_service => 'puppet00',
    server_names      => $facts['fqdn'],
    ipaddresses       => $facts['ipaddress'],
    ports             => '8140',
    options           => 'check',
  }

  @@haproxy::balancermember { "orch00-${facts['fqdn']}":
    listening_service => 'orch00',
    server_names      => $facts['fqdn'],
    ipaddresses       => $facts['ipaddress'],
    ports             => '8142',
    options           => 'check',
  }

  @@haproxy::balancermember { "mco00-${facts['fqdn']}":
    listening_service => 'mco00',
    server_names      => $facts['fqdn'],
    ipaddresses       => $facts['ipaddress'],
    ports             => '61613',
    options           => 'check',
  }
}
