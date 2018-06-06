# A Nagios server.
#
class role::nagios {
  include profile::baseline
  include profile::nagios::server
}
