# role::splunk
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include role::splunk
class role::splunk {
  require profile::base
  include profile::splunk
}
