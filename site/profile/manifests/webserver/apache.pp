# Install Apache.
#
class profile::webserver::apache {

  class { '::apache':
    default_vhost => false,
    default_mods  => false,
  }

  include ::apache::mod::ssl
}
