# profile::apache
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::apache
#
class profile::apache (
) {

  class { '::apache':
    default_vhost => false,
    default_mods  => false,
  }

  include ::apache::mod::ssl
}
