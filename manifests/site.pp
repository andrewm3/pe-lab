## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://docs.puppet.com/pe/2015.3/release_notes.html#filebucket-resource-no-longer-created-by-default
File { backup => false }

Firewall {
  require => Class['profile::baseline::linux::firewall::pre'],
  before  => Class['profile::baseline::linux::firewall::post'],
}

## Node Definitions ##

node default {
  if $trusted['extensions']['pp_role'] {
    $role = $trusted['extensions']['pp_role']
    include "role::${role}"
  } else {
    include profile::baseline
    warning('No role was found for this node. Have you set pp_role in the CSR?')
  }
}
