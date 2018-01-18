# profile::puppet::master
#
# Provides configuration for Puppet masters - both MoMs and compile masters.
#
# @example
#   include profile::puppet::master
#
class profile::puppet::master (
  Boolean $enable_firewall = true,
) {

  if $enable_firewall {
    Firewall {
      proto  => 'tcp',
      action => 'accept',
    }

    firewall { '010 Puppet Server 8140':
      dport => '8140',
    }

    firewall { '010 PE AMQ 61616':
      dport => '61616',
    }

    firewall { '010 PE MCO 61613':
      dport => '61613',
    }

    firewall { '010 PE Orchestrator 8142':
      dport => '8142',
    }
  }
}
