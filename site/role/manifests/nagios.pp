# role::nagios
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include role::nagios
#
class role::nagios {
  require profile::base
  include profile::nagios::server
}
