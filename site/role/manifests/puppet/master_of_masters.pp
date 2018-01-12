# role::puppet::master_of_masters
#
# The Puppet Enterprise MoM.
#
class role::puppet::master_of_masters {
  require profile::base
  include profile::puppet::master
  include profile::puppet::master_of_masters
}
