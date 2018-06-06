# Set any default firewall rules to apply last.
#
class profile::baseline::linux::firewall::post {

  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
