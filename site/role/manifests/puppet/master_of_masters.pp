# The Puppet Enterprise MoM.
#
class role::puppet::master_of_masters {
  include profile::baseline
  include profile::puppet::master
  include profile::puppet::master_of_masters
}
