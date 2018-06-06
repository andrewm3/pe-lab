# Manages a yum repository server.
#
class role::yumrepo {
  include profile::baseline
  include profile::apache
  include profile::yumrepo
}
