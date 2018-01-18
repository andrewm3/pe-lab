# profile::puppet::master_of_masters
#
# Manage the PE MoM-specific configuration.
#
class profile::puppet::master_of_masters (
  Boolean $enable_firewall = true,
  Hash    $node_groups     = {},
) {

  if $enable_firewall {
    Firewall {
      proto  => 'tcp',
      action => 'accept',
    }

    firewall { '010 Puppet Code Manager 8170':
      dport => '8170',
    }

    firewall { '010 PuppetDB 8081':
      dport => '8081',
    }

    firewall { '010 Puppet Console 443':
      dport => '443',
    }

    firewall { '010 Puppet Classifier 4433':
      dport => '4433',
    }

    firewall { '010 PE Orchestrator 8143':
      dport => '8143',
    }

    firewall { '010 PE Postgres 5432':
      dport => '5432',
    }
  }

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
