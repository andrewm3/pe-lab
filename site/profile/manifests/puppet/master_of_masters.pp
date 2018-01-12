# profile::puppet::master_of_masters
#
# Manage the PE MoM-specific configuration.
#
class profile::puppet::master_of_masters (
  Hash             $node_groups       = {},
) {

  # Configure node_manager module
  file { '/etc/puppetlabs/puppet/node_manager.yaml':
    ensure  => file,
    mode    => '0644',
    content => "---
hostcert: /etc/puppetlabs/puppet/ssl/certs/${trusted['certname']}.pem
hostprivkey: /etc/puppetlabs/puppet/ssl/private_keys/${trusted['certname']}.pem
localcacert: /etc/puppetlabs/puppet/ssl/certs/ca.pem
",
  }

  # Manage any specified PE Classifier node groups
  $node_groups.each |$group_name, $group_attributes| {
    node_group { $group_name:
      require => File['/etc/puppetlabs/puppet/node_manager.yaml'],
      *       => $group_attributes,
    }
  }
}
