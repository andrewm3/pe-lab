# role::puppet::compile_master
#
# The Puppet Enterprise compile masters.
#
class role::puppet::compile_master {
  require profile::base
  include profile::puppet::master
  include profile::puppet::compile_master
}
