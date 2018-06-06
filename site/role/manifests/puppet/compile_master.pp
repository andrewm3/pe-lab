# The Puppet Enterprise compile masters.
#
class role::puppet::compile_master {
  include profile::baseline
  include profile::puppet::master
  include profile::puppet::compile_master
}
