# profile::fw::post
#
# Set any default firewall rules to apply last.
#
class profile::fw::post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
