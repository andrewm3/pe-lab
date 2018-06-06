# A single-instance Splunk server.
#
class role::splunk {
  include profile::baseline
  include profile::splunk
}
