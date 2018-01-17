# role::yumrepo
#
# Manages a yum repository server.
#
class role::yumrepo {
  require profile::base
  include profile::apache
  include profile::yumrepo
}
